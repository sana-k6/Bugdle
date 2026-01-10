//
//  ContentView.swift
//  Bugdle
//
//  Created by Sana Kulkarni on 10/01/2026.
//


import SwiftUI

struct ContentView: View {
    @StateObject var vm = BugdleViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if let problem = vm.currentProblem {
                    
                    // --- HEADER ---
                    VStack(alignment: .leading, spacing: 8) {
                        Text(problem.slug.replacingOccurrences(of: "-", with: " ").capitalized)
                            .font(.system(size: 28, weight: .bold))
                        
                        // Metadata Badges
                        HStack {
                            Badge(text: problem.language.uppercased(), color: .blue)
                            Badge(text: problem.level.uppercased(), color: .orange)
                        }
                    }
                    
                    // --- QUESTION ---
                    Text(problem.question)
                        .font(.body)
                        .lineSpacing(4)
                    
                    Divider()
                    
                    // --- EXAMPLES ---
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Examples").font(.headline)
                        
                        ForEach(problem.examples, id: \.self) { ex in
                            Text(ex)
                                .font(.system(.subheadline, design: .monospaced))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                    
                    // --- CONSTRAINTS ---
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Constraints").font(.headline)
                        Text(problem.constraints)
                            .font(.system(.callout, design: .monospaced))
                            .foregroundStyle(.secondary)
                    }
                    
                    Divider()
                    
                    // --- CODE EDITOR ---
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Debug the code").font(.title3).bold()
                        
                        ZStack(alignment: .topTrailing) {
                            TextEditor(text: $vm.userCode)
                                .font(.system(size: 14, design: .monospaced))
                                .frame(minHeight: 250)
                                .padding(5)
                                .scrollContentBackground(.hidden)
                                .background(Color(NSColor.textBackgroundColor))
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                            
                            // Lives Counter
                            Text("Lives: \(vm.attemptsLeft)")
                                .font(.caption)
                                .padding(6)
                                .background(Color.red.opacity(0.1))
                                .cornerRadius(4)
                                .padding(8)
                        }
                    }
                    
                    // --- SUBMIT ---
                    HStack {
                        Text(vm.feedback)
                            .foregroundColor(vm.gameStatus == .won ? .green : .red)
                            .font(.headline)
                        
                        Spacer()
                        
                        Button("Submit Fix") {
                            vm.submitAttempt()
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .disabled(vm.gameStatus != .playing)
                    }
                    
                } else {
                    ProgressView("Loading Bugdle...")
                }
            }
            .padding(40)
        }
        .frame(minWidth: 700, minHeight: 800)
        .onAppear {
            vm.loadDailyProblem()
        }
    }
}

// Helper View for small badges
struct Badge: View {
    let text: String
    let color: Color
    var body: some View {
        Text(text)
            .font(.caption).bold()
            .padding(4)
            .background(color.opacity(0.1))
            .cornerRadius(4)
    }
}

#Preview {
    ContentView()
}