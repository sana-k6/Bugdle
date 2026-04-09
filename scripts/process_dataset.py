import json
from datasets import load_dataset

ds = load_dataset("Rtian/DebugBench")

# check language values first
id = 0 
countLang = {"python3": 0, "java": 0}
countDiff = {"easy": 0, "medium": 0, "hard": 0}  # easy, medium, hard
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

        if puzzle["language"] == "java":
            countLang["java"] += 1
        elif puzzle["language"] == "python3":
            countLang["python3"] += 1
        if puzzle["level"] == "easy":
            countDiff["easy"] += 1
        elif puzzle["level"] == "medium":
            countDiff["medium"] += 1
        elif puzzle["level"] == "hard":
            countDiff["hard"] += 1

with open("data/puzzles.json", "w") as f:
    json.dump(puzzles, f, indent=4)

print(f"Total puzzles: {id}")
print(f"Java puzzles: {countLang['java']}")
print(f"Python puzzles: {countLang['python3']}")
print(f"Easy puzzles: {countDiff['easy']}")
print(f"Medium puzzles: {countDiff['medium']}")
print(f"Hard puzzles: {countDiff['hard']}")