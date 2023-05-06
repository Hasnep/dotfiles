#!/usr/bin/env python3

import re
import sys

for line in sys.stdin:
    if line.startswith("export"):
        match = re.match(r"export (.+)=\"(.+)\"", line)
        if match:
            var = match.group(1)
            value = match.group(2)
            if var == "PATH":
                values = value.split(":")
                for value in values:
                    print(f"fish_add_path --move {value}")
            else:
                print(f"set --export {var} {value}")
