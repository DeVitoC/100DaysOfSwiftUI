//
//  ContentView.swift
//  RockPaperScissorsTrainer
//
//  Created by Christopher DeVito on 3/2/22.
//

import SwiftUI

struct ContentView: View {
    private let possibleMoves: [Moves] = [.rock, .paper, .scissors]
    private let winningMoves: [Moves] = [.paper, .scissors, .rock]
    private let losingMoves: [Moves] = [.scissors, .rock, .paper]

    @State private var currentChoice = 0//Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var didAnswerCorrectly = false
    @State private var didAnswerWrong = false
    @State var score = 0

    var body: some View {

        NavigationView {
            VStack {
                Group {
                    Spacer()
                    Spacer()
                }
                Text("Your Score is: \(score)")
                Text("If opponent chooses \(possibleMoves[currentChoice].rawValue)")
                Text("and you should \(shouldWin ? "win" : "lose")")
                Spacer()
                Section {
                    VStack(spacing: 10) {
                        Button(action: {
                            testSelection(senderMove: .rock)
                        }, label: {
                            HStack {
                                Image(systemName: "circle.fill")
                                Text("Rock")
                            }
                        })
                        Button(action: {
                            testSelection(senderMove: .paper)
                        }, label: {
                            HStack {
                                Image(systemName: "newspaper")
                                Text("Paper")
                            }
                        })
                        Button(action: {
                            testSelection(senderMove: .scissors)
                        }, label: {
                            HStack {
                                Image(systemName: "scissors")
                                Text("Scissors")
                            }
                        })
                    }
                    .alert("Great Job!!", isPresented: $didAnswerCorrectly) {
                        Button("Continue", action: reset)
                    } message: {
                        Text("Your score: \(score)")
                    }
                    .alert("Not quite. Try Again", isPresented: $didAnswerWrong) {
                        Button("Continue", action: reset)
                    } message: {
                        Text("Your score: \(score)")
                    }
                } header: {
                    Text("Which option would you select")
                }
                Group {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }
            .navigationTitle("Rock, Paper, Scissors")
        }
    }

    func testSelection(senderMove: Moves) {
        let correctMove = shouldWin ? winningMoves[currentChoice] : losingMoves[currentChoice]

        if senderMove == possibleMoves[currentChoice] {
            didAnswerWrong.toggle()
        } else if senderMove == correctMove {
            score += 1
            didAnswerCorrectly.toggle()
        } else {
            didAnswerWrong.toggle()
        }
    }

    func reset() {
        currentChoice = Int.random(in: 0...2)
        shouldWin.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum Moves: String {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
}
