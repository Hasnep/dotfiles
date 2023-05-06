#!/usr/bin/env python3

import argparse
import json
import sys
from collections import OrderedDict
from pathlib import Path
from typing import Any, Dict, List, Optional, Union

Json = Union[str, int, float, List["Json"], Dict[str, "Json"]]


def sort_by(value: Json) -> str:
    match value:
        case str() | int() | float():
            return str(value)
        case list():
            return "_" + "".join(str(x) for x in value)
        case dict():
            return sort_by(list(value.keys()))


def sort_json(data: Json) -> Any:
    match data:
        case str() | int() | float():
            return data
        case list():
            return sorted([sort_json(x) for x in data], key=sort_by)
        case dict():
            return OrderedDict(
                sorted(
                    [(k, sort_json(v)) for k, v in data.items()],
                    key=lambda x: sort_by(x[0]),
                )
            )


def get_input_file_path() -> Optional[Path]:
    parser = argparse.ArgumentParser()
    parser.add_argument("input_file_path", type=Path, default=None, nargs="?")
    args = parser.parse_args()
    return args.input_file_path


def read_input(input_file_path: Optional[Path]) -> Json:
    if input_file_path is None:
        return json.load(sys.stdin)
    else:
        with open(input_file_path, "r") as f:
            return json.load(f)


def main():
    input_file_path = get_input_file_path()
    data = read_input(input_file_path)
    data_sorted = sort_json(data)
    print(json.dumps(data_sorted, ensure_ascii=False))


if __name__ == "__main__":
    main()
