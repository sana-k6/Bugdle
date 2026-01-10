//
//  BugdleViewModel.swift
//  Bugdle
//
//  Created by Sana Kulkarni on 10/01/2026.
//


import Foundation
import SwiftUI
import Combine

class BugdleViewModel: ObservableObject {
    @Published var currentProblem: BugProblem?
    @Published var userCode: String = ""
    @Published var attemptsLeft: Int = 5
    @Published var gameStatus: GameStatus = .playing
    @Published var feedback: String = ""
    
    enum GameStatus { case playing, won, lost }

    func loadDailyProblem() {
        // 1. Locate the file in the app bundle
        guard let url = Bundle.main.url(forResource: "BugdleData", withExtension: "json") else {
            print("CRITICAL ERROR: BugdleData.json not found. Did you drag it into Xcode?")
            return
        }
        
        do {
            // 2. Decode the data
            let data = try Data(contentsOf: url)
            let allProblems = try JSONDecoder().decode([BugProblem].self, from: data)
            
            // 3. FILTER: Only Java and Python
            let allowed = ["java", "python"]
            let filtered = allProblems.filter { allowed.contains($0.language.lowercased()) }
            
            // 4. PICK: Select today's bug based on date
            if !filtered.isEmpty {
                let day = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 0
                let selected = filtered[day % filtered.count]
                
                DispatchQueue.main.async {
                    self.currentProblem = selected
                    self.userCode = selected.buggy_code
                }
            } else {
                print("No Java/Python problems found in dataset.")
            }
        } catch {
            print("JSON Error: \(error)")
        }
    }

    func submitAttempt() {
        guard let problem = currentProblem else { return }
        
        // Normalize code to ignore spaces/newlines
        let cleanUser = userCode.filter { !$0.isWhitespace }
        let cleanSol = problem.solution.filter { !$0.isWhitespace }

        if cleanUser == cleanSol {
            gameStatus = .won
            feedback = "Success! You squashed the bug."
        } else {
            attemptsLeft -= 1
            feedback = "Incorrect. \(attemptsLeft) attempts remaining."
            if attemptsLeft <= 0 {
                gameStatus = .lost
                feedback = "Game Over. Ideally, it was: \n\(problem.solution)"
            }
        }
    }
}