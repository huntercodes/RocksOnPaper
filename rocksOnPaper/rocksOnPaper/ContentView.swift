//
//  ContentView.swift
//  rocksOnPaper
//
//  Created by hunter downey on 11/5/21.
//

import SwiftUI

struct ContentView: View {
    let moves = ["🪨", "🧻", "✂️"]
    @State private var cpuChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var questionCount = 1
    @State private var showingResults = false
    var body: some View {
        VStack {
            Spacer()
            Text("Computer has played....")
                .font(.largeTitle)
            Text(moves[cpuChoice])
                .font(.system(size: 187))
            if shouldWin {
                Text("Which one wins?")
                    .foregroundColor(.green)
                    .font(.title)
            } else {
                Text("Which one loses?")
                    .foregroundColor(.red)
                    .font(.title)
            }
            HStack {
                ForEach(0..<3) { number in
                    Button(moves[number]) {
                        play(choice: number)
                    }
                    .font(.system(size: 97))
                }
            }
            Spacer()
            Text("Score: \(score)")
                .font(.subheadline)
            Spacer()
        }
        .alert("Game over", isPresented: $showingResults) {
            Button("Play again", action: reset)
        } message: {
            Text("Your score was \(score)")
        }
    }
    func play(choice: Int) {
        let winningMoves = [1, 2, 0]
        let didWin: Bool
        if shouldWin {
            didWin = choice == winningMoves[cpuChoice]
        } else {
            didWin = winningMoves[choice] == cpuChoice
        }
        if didWin {
            score += 1
        } else {
            score -= 1
        }
        if questionCount == 10 {
            showingResults = true
        } else {
            cpuChoice = Int.random(in: 0..<3)
            shouldWin.toggle()
            questionCount += 1
        }
    }
    func reset() {
        cpuChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
        questionCount = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
