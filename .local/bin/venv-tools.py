#!/usr/bin/python3
# -*- coding: utf-8 -*-

import argparse
import subprocess
import sys
from pathlib import Path
from typing import Optional, List

VENVS_DIRECTORY = Path().home() / ".venvs"

# Create a cli parser
parser = argparse.ArgumentParser(description="Control venvs")

parser.add_argument("action", type=str)
parser.add_argument("venv_name", type=str)
# The extend argument is only available in Python >=3.8
if sys.version_info.major == 3 and sys.version_info.major >= 8:
    parser.add_argument(
        "--packages", type=str, nargs="+", action="extend", required=False
    )
else:
    parser.add_argument("--packages", type=str, nargs="+", required=False)


def _pip_install(venv_python: Path, package: str):
    subprocess.check_call([venv_python, "-m", "pip", "install", "-U", package])
    print(f"Installed '{package}'.")


def venv_create(venv_name: str):
    # Ensure venvs folder exists
    VENVS_DIRECTORY.mkdir(parents=True, exist_ok=True)
    # Create venv
    venv_directory = VENVS_DIRECTORY / venv_name
    print(f"Creating venv at {venv_directory}.")
    subprocess.check_call([sys.executable, "-m", "venv", venv_directory])
    # Install needed packages
    venv_python = venv_directory / "bin" / "python"
    for package in ["pip", "setuptools", "wheel"]:
        _pip_install(venv_python, package)


def venv_auto(venv_name: str, packages: Optional[List[str]]):
    venv_create(venv_name)
    venv_python = VENVS_DIRECTORY / venv_name / "bin" / "python"
    if packages is None:
        packages = [venv_name]
    for package in packages:
        _pip_install(venv_python, package)


if __name__ == "__main__":
    args = parser.parse_args()
    if args.action == "auto":
        venv_auto(args.venv_name, args.packages)
    elif args.action == "create":
        venv_create(args.venv_name)
