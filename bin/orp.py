#!/usr/bin/python3

import os
import re
from argparse import ArgumentParser
from typing import NamedTuple

# Directory containing markdown files
SOURCE_DIR = (
    "/Users/ffekirnew/library/Mobile Documents/iCloud~md~obsidian/Documents/ffekirnew"
)
DAILY_NOTES_DIR = "daily-notes"
DATE_CUTTOFF = 10
MARKDOWN_EXTENSION = ".md"
FileDetails = NamedTuple(
    "FileDetails",
    [
        ("unchecked_tasks", list[str]),
        ("unchecked_empty_tasks", int),
    ],
)
Args = NamedTuple(
    "Args",
    [
        ("daily_note", int),
        ("start_date", str),
    ],
)


def main() -> None:
    for file_name, file_path in _filter_files():
        try:
            with open(file_path, "r") as f:
                file_details = _process_file(f.readlines())

                unchecked_tasks, empty_tasks = file_details
                if unchecked_tasks or empty_tasks:
                    print(
                        f"🕐File: {file_name} has {empty_tasks} empty tasks and {len(unchecked_tasks)} unchecked tasks:"
                    )
                    for task in unchecked_tasks:
                        print(f"\t{task}")

        except Exception as e:
            print(f"Error opening {file_path}: {e}")


def _filter_files() -> list[tuple[str, str]]:
    args = _parse_args()
    filtered_files: list[tuple[str, str]] = []

    for root, _, files in os.walk(SOURCE_DIR):
        for file in files:
            file_path = os.path.join(root, file)
            file_date = file[:DATE_CUTTOFF]

            if not _is_date_valid(file_date) or not file.endswith(MARKDOWN_EXTENSION):
                continue

            if args.start_date and file_date < args.start_date:
                continue

            if args.daily_note and file_path.find("daily-notes") < 0:
                continue

            filtered_files.append((file, file_path))

    filtered_files.sort()
    if args.daily_note:
        print("📅Processing the latest daily note(s).")
        filtered_files = filtered_files[-args.daily_note :]

    return filtered_files


def _process_file(content: list[str]) -> FileDetails:
    unchecked_tasks = [
        _clean_line(line) for line in content if _clean_line(line).startswith("- [ ]")
    ]

    return FileDetails(
        unchecked_tasks=[
            task for task in unchecked_tasks if not task.endswith("- [ ]")
        ],
        unchecked_empty_tasks=len(
            [task for task in unchecked_tasks if task.endswith("- [ ]")]
        ),
    )


def _parse_args() -> Args:
    parser = ArgumentParser(description="Obsidian Report.")
    parser.add_argument(
        "-d",
        "--daily-note",
        dest="daily_note",
        type=int,
        default=0,
        help="If specified, will only process the latest n daily notes.",
    )
    parser.add_argument(
        "-s",
        "--start-date",
        dest="start_date",
        type=str,
        help="Must be in 'yyyy-mm-dd' format. If specified, will only process notes starting on this date.",
    )

    parsed = parser.parse_args()
    args = Args(
        daily_note=parsed.daily_note if parsed.daily_note else 0,
        start_date=parsed.start_date if _is_date_valid(parsed.start_date) else "",
    )

    return args


def _is_date_valid(date: str) -> bool:
    if not date:
        return False

    pattern = r"^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$"
    return bool(re.match(pattern, date))


def _clean_line(line: str) -> str:
    return line.strip()


# Call the function with your directory path
if __name__ == "__main__":
    main()
