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
        HSplitView {
            // --- LEFT COLUMN: Problem Description ---
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if let problem = vm.currentProblem {
                        
                        // Header & Title
                        VStack(alignment: .leading, spacing: 10) {
                            Text(problem.slug.replacingOccurrences(of: "-", with: " ").capitalized)
                                .font(.system(size: 26, weight: .bold))
                            
                            // Metadata Badges
                            HStack {
                                Badge(text: problem.language.uppercased(), color: .blue)
                                Badge(text: problem.level.uppercased(), color: .orange)
                            }
                        }
                        
                        Divider()
                        
                        Text(problem.question)
                            .font(.body)
                            .lineSpacing(4)
                        
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Examples")
                                .font(.headline)
                            
                            ForEach(problem.examples, id: \.self) { ex in
                                Text(ex)
                                    .font(.system(.subheadline, design: .monospaced))
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }
                        }
                        
                       
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Constraints")
                                .font(.headline)
                            Text(problem.constraints)
                                .font(.system(.callout, design: .monospaced))
                                .foregroundStyle(.secondary)
                        }
                        
                    } else {
                        ProgressView("Loading Problem...")
                            .padding()
                    }
                }
                .padding(30)
            }
            .frame(minWidth: 400, maxWidth: .infinity) // Left pane constraints
            
            VStack(alignment: .leading, spacing: 0) {
                
                
                HStack {
                    Text("Debug the code")
                        .font(.headline)
                    Spacer()
                    if let problem = vm.currentProblem {
                        Text(problem.language.capitalized)
                            .font(.caption)
                            .padding(4)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(4)
                    }
                }
                .padding()
                .background(Color(NSColor.windowBackgroundColor))
                
                Divider()
                // 2. Vertical Split View (Adjustable Divider)
                                VSplitView {
                                    
                                    // TOP HALF: Code Editor
                                    ZStack(alignment: .topTrailing) {
                                        TextEditor(text: $vm.userCode)
                                            .font(.system(size: 14, design: .monospaced))
                                            .scrollContentBackground(.hidden)
                                            .background(Color(NSColor.textBackgroundColor))
                                            .padding(5)
                                    }
                                    .frame(minHeight: 200) // Ensure editor doesn't get squashed too small
                                    
                                    // BOTTOM HALF: Action Bar / Results
                                    // Wrapped in a ZStack/VStack to provide background and structure
                                    VStack(spacing: 0) {
                                        Divider() // Visual separation line
                                        
                                        HStack {
                                            // Lives / Feedback
                                            VStack(alignment: .leading) {
                                                Text("Lives: \(vm.attemptsLeft)")
                                                    .font(.caption).bold()
                                                
                                                if !vm.feedback.isEmpty {
                                                    Text(vm.feedback)
                                                        .font(.caption)
                                                        .foregroundColor(vm.gameStatus == .won ? .green : .red)
                                                        .fixedSize(horizontal: false, vertical: true) // Allow text to wrap if feedback is long
                                                }
                                            }
                                            
                                            Spacer()
                                            
                                            Button("Submit Fix") {
                                                vm.submitAttempt()
                                            }
                                            .buttonStyle(.borderedProminent)
                                            .controlSize(.large)
                                            .disabled(vm.gameStatus != .playing)
                                        }
                                        .padding()
                                        
                                        // Spacer to push content up if the user drags the divider way up
                                        Spacer()
                                    }
                                    .background(Color(NSColor.windowBackgroundColor))
                                    .frame(minHeight: 100) // Ensure submit button doesn't disappear
                                }
                            }
                            .frame(minWidth: 400, maxWidth: .infinity)
                        }
                        .frame(minWidth: 900, minHeight: 600)
                        .onAppear {
                            vm.loadDailyProblem()
                        }
                    }
                }

// Helper for the badges
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
