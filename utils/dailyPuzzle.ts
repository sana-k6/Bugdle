import {Puzzle} from "./types"
import puzzlesList from "../data/puzzles.json"

const puzzles = puzzlesList as Puzzle[]
function getTodaysPuzzle(): Puzzle {
    const today = new Date();
    const origin = new Date("2026-04-03");
    today.setHours(0, 0, 0, 0);
    const daysSince = Math.floor((today.getTime() - origin.getTime()) / (1000 * 60 * 60 * 24))+1;
    const puzzleIndex = daysSince % puzzles.length;
    return puzzles[puzzleIndex];
}

export default getTodaysPuzzle