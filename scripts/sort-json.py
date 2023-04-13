#!/usr/bin/env python3

import argparse
import json
import sys
from typing import List, Dict, Union, Any, Tuple, Optional
from pathlib import Path
from collections import OrderedDict


JsonType = Union[str, int, float, List[Any], Dict[str, Any], Tuple[str, Any]]


def sort_json(data: Any) -> Any:
    def sort_by(x: JsonType) -> str:
        if isinstance(x, str):
            return x
        elif isinstance(x, int) or isinstance(x, float):
            return str(x)
        elif isinstance(x, tuple):
            return str(x[0])
        elif isinstance(x, list) or isinstance(x, dict):
            return "_"
        else:
            print("Couldn't convert")
            exit(1)

    if isinstance(data, list):
        return sorted(map(sort_json, data), key=sort_by)
    if isinstance(data, dict):
        return OrderedDict(
            sorted([(k, sort_json(v)) for k, v in data.items()], key=sort_by)
        )
    if isinstance(data, str) or isinstance(data, int) or isinstance(data, float):
        return data
    else:
        print("Couldn't sort!")
        exit(1)


def get_input_file_path() -> Optional[Path]:
    parser = argparse.ArgumentParser()
    parser.add_argument("input_file_path", type=Path,default=None, nargs="?" )
    args = parser.parse_args()
    return args.input_file_path


def read_input(input_file_path: Optional[Path]) -> JsonType:
    if input_file_path is None:
        return json.load(sys.stdin)
    else:
        with open(input_file_path, "r") as f:
            return json.load(f)


def main():
    input_file_path = get_input_file_path()
    data = read_input(input_file_path)
    data_sorted = sort_json(data)
    print(json.dumps(data_sorted))


if __name__ == "__main__":
    main()
