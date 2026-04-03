export type Language = "python3" | "java"
export type Level = "easy" | "medium" | "hard"
export type State = "playing" | "won" | "lost"
export type Puzzle ={
    id: number,
    slug : string,
    category : string,
    subtype : string,
    language : Language,
    level : Level,
    release_time : number,
    question : string,
    examples : string[],
    constraints : string,
    solution : string,
    solution_explanation : string,
    buggy_code: string,
    bug_explanation: string,
}

export type DailyState = {
    puzzle: number,
    attempts: string[],
    currentAttempt: string,
    currentState: State,
    date: number,
}