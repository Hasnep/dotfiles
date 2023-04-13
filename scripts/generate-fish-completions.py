#!/usr/bin/env python3

import os
import subprocess
from pathlib import Path

config_directory = os.getenv("XDG_CONFIG_HOME")
if config_directory is None:
    print("Environment variable `XDG_CONFIG_HOME` not set.")
    exit(1)

fish_completions_folder = Path(config_directory) / "fish" / "completions"

for tool, command in [
    ("antidot", "antidot completion fish"),
    ("bin", "bin completion fish"),
    ("just", "just --completions fish"),
    ("trash", "trash completions fish"),
    ("zellij", "zellij setup --generate-completion fish"),
]:
    if subprocess.run(f"type {tool}", shell=True, capture_output=True).returncode == 0:
        completion_file = fish_completions_folder / f"{tool}.fish"
        print(f"Generating completions for {tool} in {completion_file}.")
        completions = subprocess.run(
            command, shell=True, capture_output=True, text=True
        ).stdout
        with open(completion_file, "w") as f:
            f.write(completions)
