#!/usr/bin/env python3

import json
import os
import subprocess
from argparse import ArgumentParser
from dataclasses import dataclass
from pathlib import Path
from textwrap import dedent
from typing import Dict, List, NotRequired, Optional, TypedDict, TypeVar

# Types

T = TypeVar("T")
PackageManagerConfigDict = TypedDict(
    "PackageManagerConfigDict",
    {"packages": List[str], "force": NotRequired[bool], "ignore": NotRequired[bool]},
)
PackageManagerConfig = PackageManagerConfigDict | List[str]
PackageDict = TypedDict(
    "PackageDict",
    {
        "guix": NotRequired[PackageManagerConfig],
        "apt": NotRequired[PackageManagerConfig],
        "nix": NotRequired[PackageManagerConfig],
        "flatpak": NotRequired[PackageManagerConfig],
    },
)

# Constants

XDG_CONFIG_HOME = Path(os.getenv("XDG_CONFIG_HOME", Path.home() / ".config"))
XDG_DATA_HOME = Path(os.getenv("XDG_DATA_HOME", Path.home() / ".local" / "share"))


# Utils


def flatten(nested_list: List[List[T]]) -> List[T]:
    return [item for sublist in nested_list for item in sublist]


def enquote(s: str) -> str:
    return f'"{s}"'


# Cli


@dataclass
class CliArgs:
    packages_file_path: Path
    # Manifests
    guix_manifest_file_path: Path
    apt_manifest_file_path: Path
    nix_manifest_folder_path: Path
    flatpak_manifest_file_path: Path
    # Profiles
    guix_profile_path: Path
    nix_profile_path: Path


def get_cli_args() -> CliArgs:
    parser = ArgumentParser()
    parser.add_argument("--packages-file", type=Path, required=True)
    parser.add_argument("--guix-manifest-file", type=Path, required=True)
    parser.add_argument("--apt-manifest-file", type=Path, required=True)
    parser.add_argument("--nix-manifest-folder", type=Path, required=True)
    parser.add_argument("--flatpak-manifest-file", type=Path, required=True)
    parser.add_argument(
        "--guix-profile-path",
        type=Path,
        default=XDG_DATA_HOME / "guix-profiles" / "default",
    )
    parser.add_argument(
        "--nix-profile-path", type=Path, default=XDG_DATA_HOME / "nix-profile"
    )
    args = parser.parse_args()
    return CliArgs(
        args.packages_file,
        args.guix_manifest_file,
        args.apt_manifest_file,
        args.nix_manifest_folder,
        args.flatpak_manifest_file,
        args.guix_profile_path,
        args.nix_profile_path,
    )


# Packaging


class Packages:
    def __init__(
        self, package_names: List[str], package_manager: str, force: bool, ignore: bool
    ) -> None:
        self.package_names = package_names
        self.package_manager = package_manager

        # Both force and ignore are mutually exclusive
        if force and ignore:
            raise Exception(
                f"Both `force` and `ignore` were both set for packages `{', '.join(package_names)}` from `{package_manager}`."
            )

        self.force = force
        self.ignore = ignore


class UniPackage:
    def __init__(
        self,
        command: str,
        guix: Optional[PackageManagerConfig],
        apt: Optional[PackageManagerConfig],
        nix: Optional[PackageManagerConfig],
        flatpak: Optional[PackageManagerConfig],
        ignore: Optional[bool],
    ):
        self.command_name = command

        def get_packages(
            package_manager: str, x: Optional[PackageManagerConfig]
        ) -> Optional[Packages]:
            if isinstance(x, list):
                return Packages(x, package_manager, False, False)
            elif isinstance(x, dict):
                return (
                    None
                    if x.get("ignore", False)
                    else Packages(
                        x["packages"],
                        package_manager,
                        x.get("force", False),
                        x.get("ignore", False),
                    )
                )
            else:
                return None

        self.ignore = ignore
        self.guix = get_packages("guix", guix)
        self.apt = get_packages("apt", apt)
        self.nix = get_packages("nix", nix)
        self.flatpak = get_packages("flatpak", flatpak)


def read_packages_file(packages_file_path: Path) -> List[UniPackage]:
    try:
        with open(packages_file_path, "r") as f:
            packages: Dict[str, Dict[str, PackageDict]] = json.load(f)
    except FileNotFoundError:
        raise Exception(f"Packages file not found: `{packages_file_path}`.")

    commands_and_packages = flatten(
        [
            list(packages.items())
            for category, packages in packages.items()
            if category not in ["ignore", "ignored"]
        ]
    )
    return [
        UniPackage(
            command=command,
            guix=p.get("guix"),
            apt=p.get("apt"),
            nix=p.get("nix"),
            flatpak=p.get("flatpak"),
            ignore=p.get("ignore"),
        )
        for command, p in commands_and_packages
    ]


def is_command_installed(command: str) -> bool:
    try:
        subprocess.check_output(["which", command])
        return True
    except subprocess.CalledProcessError:
        return False


def get_installed_package_managers() -> List[str]:
    package_managers = ["guix", "nix", "apt", "flatpak"]
    return [command for command in package_managers if is_command_installed(command)]


def get_package_managers_to_install(
    p: UniPackage, installed_package_managers: List[str]
) -> List[str]:
    if p.ignore:
        return []

    is_flatpak_installed = "flatpak" in installed_package_managers
    is_guix_installed = "guix" in installed_package_managers
    is_apt_installed = "apt" in installed_package_managers
    is_nix_installed = "nix" in installed_package_managers

    (has_flatpak_package, force_flatpak, ignore_flatpak) = (
        (False, False, False)
        if p.flatpak is None
        else (True, p.flatpak.force, p.flatpak.ignore)
    )
    (has_guix_package, force_guix, ignore_guix) = (
        (False, False, False) if p.guix is None else (True, p.guix.force, p.guix.ignore)
    )
    (has_apt_package, force_apt, ignore_apt) = (
        (False, False, False) if p.apt is None else (True, p.apt.force, p.apt.ignore)
    )
    (has_nix_package, force_nix, ignore_nix) = (
        (False, False, False) if p.nix is None else (True, p.nix.force, p.nix.ignore)
    )

    # Install using flatpak if it is installed and has a package
    install_using_flatpak = (
        not ignore_flatpak
        and is_flatpak_installed
        and has_flatpak_package
        and (force_flatpak or True)
    )
    # Install using guix if it is installed and has a package and the same package is not installed using flatpak
    install_using_guix = (
        not ignore_guix
        and is_guix_installed
        and has_guix_package
        and (force_guix or not install_using_flatpak)
    )
    # Install using apt if it is installed and has a package and the same package is not installed using guix
    install_using_apt = (
        not ignore_apt
        and is_apt_installed
        and has_apt_package
        and (not (install_using_flatpak or install_using_guix) or force_apt)
    )
    # Install using nix if it is installed and has a package and the same package is not installed using guix or apt
    install_using_nix = (
        not ignore_nix
        and is_nix_installed
        and has_nix_package
        and (
            not (install_using_flatpak or install_using_guix or install_using_apt)
            or force_nix
        )
    )

    return list(
        {
            k: v
            for (k, v) in {
                "guix": install_using_guix,
                "apt": install_using_apt,
                "nix": install_using_nix,
                "flatpak": install_using_flatpak,
            }.items()
            if v
        }.keys()
    )


def get_guix_manifest(packages_to_install: List[Packages]) -> str:
    # Flatten list of package names
    package_names_to_install = flatten([p.package_names for p in packages_to_install])
    package_names_joined = "\n".join(
        [enquote(package_name) for package_name in sorted(package_names_to_install)]
    )
    return f"(specifications->manifest '({package_names_joined}))"


def get_apt_manifest(
    packages_to_install: List[Packages], packages_to_remove: List[Packages]
) -> str:
    package_names_to_install = flatten([p.package_names for p in packages_to_install])
    package_names_to_remove = [
        package_name
        for package_name in flatten([p.package_names for p in packages_to_remove])
        if package_name not in package_names_to_install
    ]
    return "\n".join(
        [
            "sudo nala remove " + " ".join(sorted(package_names_to_remove))
            if len(package_names_to_remove) > 0
            else "",
            "sudo nala install " + " ".join(sorted(package_names_to_install))
            if len(package_names_to_install) > 0
            else "",
        ]
    )


def get_nix_manifest(packages_to_install: List[Packages]) -> str:
    # Flatten lists of package names
    package_names_to_install = flatten([p.package_names for p in packages_to_install])
    packages_joined = " ".join(
        [f"pkgs.{package_name}" for package_name in sorted(package_names_to_install)]
    )
    return dedent(
        f"""
        {{ config, pkgs, ... }}: {{
        home.username = "hannes";
        home.homeDirectory = "{Path().home()}";
        home.stateVersion = "22.11";
        home.packages = [
            {packages_joined}
        ];
        programs.home-manager.enable = true; # Let Home Manager install and manage itself.
        }}
        """
    )


def get_flatpak_manifest(
    packages_to_install: List[Packages], packages_to_remove: List[Packages]
) -> str:
    package_names_to_install = flatten([p.package_names for p in packages_to_install])
    package_names_to_remove = [
        package_name
        for package_name in flatten([p.package_names for p in packages_to_remove])
        if package_name not in package_names_to_install
    ]
    uninstall_command = (
        ["flatpak uninstall " + " ".join(sorted(package_names_to_remove))]
        if len(package_names_to_remove) > 0
        else []
    )
    install_command = (
        [
            "flatpak install " + " ".join(sorted(package_names_to_install)),
        ]
        if len(package_names_to_install) > 0
        else []
    )
    return "\n".join(uninstall_command + install_command)


def format_guix_manifest(manifest_file_path: Path) -> None:
    format_command = ["guix", "style", "--whole-file", str(manifest_file_path)]
    print(f"Formatting manifest file using command `{' '.join(format_command)}`.")
    subprocess.run(format_command, capture_output=True)


def format_nix_manifest(manifest_file_path: Path) -> None:
    format_command = (
        ["alejandra"]
        if is_command_installed("alejandra")
        else ["nix", "run", "nixpkgs#alejandra", "--"]
    ) + [str(manifest_file_path)]
    print(f"Formatting manifest file using command `{' '.join(format_command)}`.")
    subprocess.run(format_command, capture_output=True)


def get_guix_install_command(command_line_arguments: CliArgs) -> str:
    return " ".join(
        [
            "guix",
            "package",
            f"--manifest={command_line_arguments.guix_manifest_file_path}",
            f"--profile={command_line_arguments.guix_profile_path}",
        ]
    )


def get_apt_install_command(command_line_arguments: CliArgs) -> str:
    return " ".join(["source", str(command_line_arguments.apt_manifest_file_path)])


def get_nix_install_command(command_line_arguments: CliArgs) -> str:
    return " ".join(["nix", "run", "home-manager/master", "--", "switch"])


def get_flatpak_install_command(command_line_arguments: CliArgs) -> str:
    return " ".join(["source", str(command_line_arguments.flatpak_manifest_file_path)])


if __name__ == "__main__":
    cli_args = get_cli_args()
    installed_package_managers = get_installed_package_managers()
    packages = [
        (p, get_package_managers_to_install(p, installed_package_managers))
        for p in read_packages_file(cli_args.packages_file_path)
    ]

    if "guix" in installed_package_managers:
        guix_manifest = get_guix_manifest(
            [
                p.guix
                for p, install_with in packages
                if p.guix is not None and "guix" in install_with
            ]
        )
        with open(cli_args.guix_manifest_file_path, "w") as f:
            f.write(guix_manifest)
        format_guix_manifest(cli_args.guix_manifest_file_path)

    if "apt" in installed_package_managers:
        apt_manifest = get_apt_manifest(
            [
                p.apt
                for p, install_with in packages
                if p.apt is not None and "apt" in install_with
            ],
            [
                p.apt
                for p, install_with in packages
                if p.apt is not None and "apt" not in install_with
            ],
        )
        with open(cli_args.apt_manifest_file_path, "w") as f:
            f.write(apt_manifest)

    if "nix" in installed_package_managers:
        nix_manifest = get_nix_manifest(
            [
                p.nix
                for p, install_with in packages
                if p.nix is not None and "nix" in install_with
            ]
        )

        # Create folder
        cli_args.nix_manifest_folder_path.mkdir(parents=True, exist_ok=True)

        with open(cli_args.nix_manifest_folder_path / "flake.nix", "w") as f:
            f.write(
                dedent(
                    r"""
                    {
                        description = "Home Manager configuration generated by Ubunix";
                        inputs = {
                            nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
                            home-manager = {
                            url = "github:nix-community/home-manager";
                            inputs.nixpkgs.follows = "nixpkgs";
                            };
                        };
                        outputs = { nixpkgs, home-manager, ... }:
                            let
                            system = "x86_64-linux";
                            pkgs = nixpkgs.legacyPackages.${system};
                            in {
                            homeConfigurations.hannes = home-manager.lib.homeManagerConfiguration {
                                inherit pkgs;
                                modules = [ ./home.nix ];
                            };
                        };
                    }
                    """
                )
            )
        with open(cli_args.nix_manifest_folder_path / "home.nix", "w") as f:
            f.write(nix_manifest)
        format_nix_manifest(cli_args.nix_manifest_folder_path / "flake.nix")
        format_nix_manifest(cli_args.nix_manifest_folder_path / "home.nix")

    if "flatpak" in installed_package_managers:
        flatpak_manifest = get_flatpak_manifest(
            [
                p.flatpak
                for p, install_with in packages
                if p.flatpak is not None and "flatpak" in install_with
            ],
            [
                p.flatpak
                for p, install_with in packages
                if p.flatpak is not None and "flatpak" not in install_with
            ],
        )
        with open(cli_args.flatpak_manifest_file_path, "w") as f:
            f.write(flatpak_manifest)

    for p, install_with in packages:
        if len(install_with) == 0:
            print(f"Package `{p.command_name}` was not installed.")

    print("")
    print(get_flatpak_install_command(cli_args))
    print(get_guix_install_command(cli_args))
    print(get_apt_install_command(cli_args))
    print(get_nix_install_command(cli_args))
