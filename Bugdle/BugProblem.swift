import Foundation

struct BugProblem: Codable, Identifiable {
    var id: String { slug }
    
    // The 13 Features from DebugBench
    let solution_explanation: String
    let question: String
    let examples: [String]
    let constraints: String
    let buggy_code: String
    let solution: String
    let bug_explanation: String
    let subtype: String
    let level: String
    let slug: String
    let release_time: Int64
    let language: String
    let category: String
}