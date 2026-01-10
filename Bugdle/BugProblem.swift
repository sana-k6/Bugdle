import Foundation

struct BugProblem: Codable, Identifiable {
    var id: String { slug }
    
    // The 13 Features from DebugBench
    let slug: String
    let question: String
    let examples: [String]
    let constraints: String
    let buggy_code: String
    let solution: String
    let bug_explanation: String
    let subtype: String
    let level: String
    let release_time: Int64
    let language: String
    let category: String
    let solution_explanation: String

    // Mapping JSON keys to Swift variables
    enum CodingKeys: String, CodingKey {
        case slug, question, examples, constraints, buggy_code, solution
        case bug_explanation, subtype, level, release_time, language
        case category = "single-numberCategory" // Matches your dataset key
        case solution_explanation = "solution explanation"
    }
}
