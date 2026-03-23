from datasets import load_dataset

ds = load_dataset("Rtian/DebugBench")

with open("data/puzzles.json", "w") as f:
    for item in ds["test"]:
        if(item["language"] == "python" or item["language"] == "java"):
            f.write(str(item) + "\n")
