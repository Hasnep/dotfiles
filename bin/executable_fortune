#!/usr/bin/env python3

import json
import os
import random
import sys
from argparse import ArgumentParser
from pathlib import Path
from typing import Dict, List, NamedTuple, Optional, TypeVar

T = TypeVar("T")

CONFIG_FOLDER = Path(os.getenv("XDG_CONFIG_HOME", default=Path.home() / ".config"))
FORTUNES_FILE_PATH = CONFIG_FOLDER / "fortune" / "fortunes.json"


def flatten(x: List[List[T]]) -> List[T]:
    return [item for sublist in x for item in sublist]


class CliArgs(NamedTuple):
    max_length: Optional[int]
    categories: Optional[List[str]]


def get_cli_args() -> CliArgs:
    parser = ArgumentParser()
    parser.add_argument(
        "--max-length",
        type=int,
        default=None,
        help="Maximum length of the fortune.",
    )
    parser.add_argument(
        "--categories",
        nargs="+",
        type=str,
        default=None,
        help="Categories of fortunes to pick from, defaults to all categories.",
    )
    args = parser.parse_args()
    max_length = args.max_length
    if max_length is not None and max_length <= 0:
        sys.stderr.write("Maximum length must be positive.")
        sys.exit(1)
    categories = args.categories
    return CliArgs(max_length, categories)


def read_fortunes_file(fortune_file_path: Path) -> Dict[str, List[str]]:
    try:
        with open(fortune_file_path, "r") as f:
            fortunes_str = f.read()
    except FileNotFoundError:
        sys.stderr.write(f"Fortunes file not found: `{fortune_file_path}`.")
        sys.exit(1)

    try:
        fortunes: Dict[str, List[str]] = json.loads(fortunes_str)
    except json.JSONDecodeError:
        sys.stderr.write(f"Fortunes file is not valid JSON: `{fortune_file_path}`.")
        sys.exit(1)

    return fortunes


def filter_fortunes_by_category(
    fortunes: Dict[str, List[str]], categories: Optional[List[str]]
) -> List[str]:
    fortunes_filtered = list(
        fortunes.values()
        if categories is None
        else [
            fortunes_list
            for (category, fortunes_list) in fortunes.items()
            if category in categories
        ]
    )
    return flatten(fortunes_filtered)


def filter_fortunes_by_length(
    fortunes: List[str], max_length: Optional[int]
) -> List[str]:
    fortunes_filtered = (
        fortunes
        if max_length is None
        else [fortune for fortune in fortunes if len(fortune) <= max_length]
    )
    if len(fortunes_filtered) == 0:
        sys.stderr.write(
            f"No fortunes shorter than {max_length} characters were found."
        )
        sys.exit(1)
    return fortunes_filtered


def pick_fortune(fortunes: List[str]) -> str:
    return random.choice(fortunes)


def main():
    cli_args = get_cli_args()
    fortunes = filter_fortunes_by_length(
        filter_fortunes_by_category(
            read_fortunes_file(FORTUNES_FILE_PATH), cli_args.categories
        ),
        cli_args.max_length,
    )
    fortune = pick_fortune(fortunes)
    print(fortune)


if __name__ == "__main__":
    main()
