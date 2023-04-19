#!/usr/bin/env python3.11

import json
import sys
from typing import Dict, List, NotRequired, TypedDict

# Utils


def serialise_bool(x: bool) -> str:
    return "true" if x else "false"


def indent(s: str, by: int = 2):
    return "\n".join([by * " " + line for line in s.splitlines()])


# Types

PackageDict = TypedDict(
    "PackageDict",
    {
        "ignore": NotRequired[bool],
        "comment": NotRequired[str],
        "force": NotRequired[bool],
        "packages": List[str],
    },
)

UniPackageDict = TypedDict(
    "UniPackageDict",
    {
        "ignore": NotRequired[bool],
        "comment": NotRequired[str],
        "guix": NotRequired[PackageDict | List[str]],
        "apt": NotRequired[PackageDict | List[str]],
        "nix": NotRequired[PackageDict | List[str]],
    },
)

UniPackagesDict = Dict[str, UniPackageDict]

CategoriesDict = Dict[str, UniPackagesDict]


class Package:
    def __init__(self, package: PackageDict):
        self.ignore = package.get("ignore")
        self.comment = package.get("comment")
        self.force = package.get("force")
        self.packages = package["packages"]

    def serialise(self) -> str:
        if self.ignore is None and self.comment is None and self.force is None:
            return "[" + ", ".join([package for package in self.packages]) + "]"
        return "\n" + "\n".join(
            (["comment: " + self.comment] if self.comment else [])
            + (["ignore: " + serialise_bool(self.ignore)] if self.ignore else [])
            + (["force: " + serialise_bool(self.force)] if self.force else [])
            + [
                "packages: "
                + "["
                + ", ".join([package for package in self.packages])
                + "]"
            ]
        )


class UniPackage:
    def __init__(self, uni_package: UniPackageDict):
        self.ignore = uni_package.get("ignore")
        self.comment = uni_package.get("comment")

        def apply_package_defaults(package: PackageDict | List[str]) -> PackageDict:
            if isinstance(package, list):
                return {"packages": package}
            else:
                return package

        guix = uni_package.get("guix")
        self.guix = Package(apply_package_defaults(guix)) if guix else None
        apt = uni_package.get("apt")
        self.apt = Package(apply_package_defaults(apt)) if apt else None
        nix = uni_package.get("nix")
        self.nix = Package(apply_package_defaults(nix)) if nix else None

    def serialise(self) -> str:
        return "\n".join(
            (["comment: " + self.comment] if self.comment else [])
            + (["ignore: " + serialise_bool(self.ignore)] if self.ignore else [])
            + (["guix: " + indent(self.guix.serialise())] if self.guix else [])
            + (["apt: " + indent(self.apt.serialise())] if self.apt else [])
            + (["nix: " + indent(self.nix.serialise())] if self.nix else [])
        )


class UniPackages:
    def __init__(self, uni_packages: UniPackagesDict):
        self.uni_packages = sorted(
            [
                (uni_package_name, UniPackage(uni_package))
                for uni_package_name, uni_package in uni_packages.items()
            ],
            key=lambda x: x[0],
        )

    def serialise(self) -> str:
        return "\n".join(
            [
                uni_package_name + ":" + "\n" + indent(uni_package.serialise())
                for uni_package_name, uni_package in self.uni_packages
            ]
        )


class Categories:
    def __init__(self, categories: CategoriesDict):
        self.categories = sorted(
            [
                (category, UniPackages(uni_packages))
                for category, uni_packages in categories.items()
            ],
            key=lambda x: x[0],
        )

    def serialise(self) -> str:
        return "\n".join(
            [
                category + ":" + "\n" + indent(uni_packages.serialise())
                for category, uni_packages in self.categories
            ]
        )


if __name__ == "__main__":
    packages_str = sys.stdin.read()
    packages_dict = json.loads(packages_str)
    packages = Categories(packages_dict)
    print(packages.serialise())
