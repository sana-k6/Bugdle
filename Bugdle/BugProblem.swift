import Foundation

struct BugProblem: Codable, Identifiable {
    // The 'slug' acts as the unique ID for the game
    var id: String { slug }
    
    // --- The 13 Features from your JSON ---
    let slug: String
    let question: String
    let examples: [String]       // Matches ["Input...", "Input..."]
    let constraints: String
    let buggy_code: String
    let solution: String
    let bug_explanation: String
    let subtype: String
    let level: String
    let release_time: Int        // Swift Int handles your large timestamp fine
    let language: String
    let category: String
    let solution_explanation: String
    
    // --- Helper for Date Display ---
    // Converts that massive timestamp (16917...) into a readable date
    var formattedDate: String {
        // The timestamp looks like nanoseconds? dividing by 1B to get seconds
        let seconds = TimeInterval(release_time) / 1_000_000_000
        let date = Date(timeIntervalSince1970: seconds)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium // e.g., "Aug 10, 2023"
        return formatter.string(from: date)
    }
}
