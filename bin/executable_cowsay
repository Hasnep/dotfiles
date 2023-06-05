#!/usr/bin/env python3

import sys
from textwrap import wrap
from typing import List, Literal
from unicodedata import east_asian_width

COW_RIGHT = """
        ▄  ▄
       ▄█▀█▀▄
▄▀▄███▄███████
█ █▄█  █▀█ ▀▀
  ███▀██▀█
  █ ▄ █  █
"""

COW_LEFT = """
  ▄  ▄
 ▄▀█▀█▄
███████▄███▄▀▄
 ▀▀ █▀█  █▄█ █
    █▀██▀███
    █  █ ▄ █
"""


def get_visual_width(s: str) -> int:
    def get_visual_width_character(s: str) -> int:
        flag = east_asian_width(s)
        match flag:
            case "W" | "F":
                return 2
            case _:
                return 1

    return sum(get_visual_width_character(c) for c in s)


def left_justify(s: str, width: int) -> str:
    return s + " " * (width - get_visual_width(s))


def pad_vertically(
    message: str, pad_to_height: int, add_to: Literal["top", "bottom"]
) -> str:
    message_lines = message.splitlines()
    width = get_visual_width(message_lines[0])
    height = len(message_lines)
    if height < pad_to_height:
        padding = [" " * (width)] * (pad_to_height - height)
        return "\n".join(
            (padding if add_to == "top" else [])
            + message_lines
            + (padding if add_to == "bottom" else [])
        )

    else:
        return message


def juxtapose_horizontally(a: str, b: str, separator: str) -> str:
    return "\n".join(
        [
            line_a + separator + line_b
            for (line_a, line_b) in zip(a.splitlines(), b.splitlines(), strict=True)
        ]
    )


def get_message() -> str:
    return sys.stdin.read()


def wrap_and_justify_message(message: str, width: int) -> List[str]:
    message_wrapped = wrap(message, width)
    maximum_line_width = max([get_visual_width(line) for line in message_wrapped])
    return [left_justify(line, maximum_line_width) for line in message_wrapped]


def speech_bubble(message: List[str]) -> str:
    TOP_LEFT = "╭"
    TOP_RIGHT = "╮"
    BOTTOM_LEFT = "╰"
    BOTTOM_RIGHT = "╯"
    HORIZONTAL = "─"
    VERTICAL = "│"
    HORIZONTAL_WITH_TAIL = "┬"
    TAIL = BOTTOM_LEFT + HORIZONTAL

    message_width = get_visual_width(message[0])
    message_height = len(message)

    top_line = TOP_LEFT + (HORIZONTAL * (message_width + 2)) + TOP_RIGHT
    message_lines = [VERTICAL + " " + line + " " + VERTICAL for line in message]
    bottom_line = (
        BOTTOM_LEFT
        + HORIZONTAL * (message_width + 1)
        + HORIZONTAL_WITH_TAIL
        + BOTTOM_RIGHT
    )
    tail_line = " " * (message_width + 2) + TAIL
    speech_bubble = "\n".join([top_line, *message_lines, bottom_line, tail_line])

    return pad_vertically(speech_bubble, message_height + 6, "bottom")


def cowsay(message: str, message_width: int) -> str:
    message_lines = wrap_and_justify_message(message, message_width)
    speech_bubble_text = speech_bubble(message_lines)
    n_lines_in_speech_bubble = len(speech_bubble_text.splitlines())
    cow = pad_vertically(COW_LEFT, n_lines_in_speech_bubble, "top")
    return juxtapose_horizontally(speech_bubble_text, cow, " ")


def main():
    message = get_message()
    message_width = 20
    print(cowsay(message, message_width))


if __name__ == "__main__":
    main()
