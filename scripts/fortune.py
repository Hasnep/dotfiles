#!/usr/bin/env python3

import os
import random
import sys
from argparse import ArgumentParser
from pathlib import Path
from typing import List, Optional

CONFIG_FOLDER = Path(os.getenv("XDG_CONFIG_HOME", default=Path.home() / ".config"))
FORTUNES_FILE = CONFIG_FOLDER / "fortune" / "fortunes"


def get_max_length() -> Optional[int]:
    parser = ArgumentParser()
    parser.add_argument("--max-length", type=int, help="Maximum length of the fortune.")
    args = parser.parse_args()
    max_length = args.max_length
    if max_length is not None and max_length <= 0:
        sys.stderr.write("Maximum length must be positive.")
        sys.exit(1)
    return max_length


def get_fortunes() -> List[str]:
    try:
        with open(FORTUNES_FILE, "r") as f:
            fortunes = f.read().splitlines()
    except FileNotFoundError:
        sys.stderr.write(f"Fortunes file not found: `{FORTUNES_FILE}`.")
        sys.exit(1)

    if len(fortunes) == 0:
        sys.stderr.write("No fortunes found in fortunes file `{FORTUNES_FILE}`.")
        sys.exit(1)

    return fortunes


def pick_fortune(fortunes: List[str], max_length: Optional[int]) -> str:
    fortunes_filtered = (
        fortunes
        if max_length is None
        else [f for f in fortunes if len(f) <= max_length]
    )
    if len(fortunes_filtered) == 0:
        sys.stderr.write(f"No fortunes shorter than {max_length} found.")
        sys.exit(1)
    return random.choice(fortunes_filtered)


def main():
    max_length = get_max_length()
    fortunes = get_fortunes()
    fortune = pick_fortune(fortunes, max_length)
    print(fortune)


if __name__ == "__main__":
    main()
