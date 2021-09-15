#!/usr/bin/python3
# -*- coding: utf-8 -*-

import argparse
import json
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument("--output", type=Path)
parser.add_argument("input_file_path", type=Path)

# Parse arguments
args = parser.parse_args()
output_file_path = args.output
input_file_path = args.input_file_path

if input_file_path is None:
    print("Input file not specified")
    print("restic-excludes-compile --output=<output path> <input path>")
    exit()

# Read JSON
print(f"Reading exclude source file from '{input_file_path}'.")
with open(input_file_path, "r") as f:
    excludes = json.load(f)

# Create output string
output = ""
for category, exclude_paths in excludes.items():
    output += f"# {category}\n"
    for exclude_path in exclude_paths:
        output += f"{exclude_path}\n"

print(f"Writing exclude file to '{output_file_path}'.")
with open(output_file_path, "w") as f:
    f.write(output)

print("Done converting excludes file.")
