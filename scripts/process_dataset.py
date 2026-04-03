import json
from datasets import load_dataset

ds = load_dataset("Rtian/DebugBench")

# check language values first
id = 0 
puzzles = []
for puzzle in ds["test"]:
    if puzzle["language"] in ["python3", "java"]:
        puzzles.append({
            "id": id,
            "slug": puzzle["slug"],
            "category": puzzle["category"],
            "subtype": puzzle["subtype"],
            "language": puzzle["language"],
            "level": puzzle["level"],
            "release_time": puzzle["release_time"],
            "question": puzzle["question"],
            "examples": puzzle["examples"],
            "constraints": puzzle["constraints"],
            "solution": puzzle["solution"],
            "solution_explanation": puzzle["solution_explanation"],
            "buggy_code": puzzle["buggy_code"],
            "bug_explanation": puzzle["bug_explanation"],
        })
        id += 1

with open("data/puzzles.json", "w") as f:
    json.dump(puzzles, f, indent=4)