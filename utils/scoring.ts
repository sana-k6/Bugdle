import { Puzzle, TileState } from "./types";

export function getBugLine(puzzle:Puzzle) : {lineIndex: number, buggyLine: string, correctLine: string} | null {
    const buggyCodeLines = puzzle.buggy_code.split("\n");
    const solutionLines = puzzle.solution.split("\n");
    const length = Math.min(buggyCodeLines.length, solutionLines.length)
    for (let i = 0; i<length; i++) {
        if (buggyCodeLines[i].trim() !== solutionLines[i].trim()) {
            return {
                lineIndex: i,
                buggyLine: buggyCodeLines[i],
                correctLine: solutionLines[i],
            }
        }
    }
    return null; // No bug found
}

