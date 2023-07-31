//
//  TriviaView.swift
//  TriviaGameDemo
//
//  Created by 전수민 on 2023/07/26.
//

import SwiftUI

struct TriviaView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    var body: some View {
        if triviaManager.reachedEnd {
            VStack(spacing: 20) {
                Text("Trivia Game")
                    .mainTitle()
                
                Text("Congratulations, you completedthe game! 🥳")
                
                Text("you scored \(triviaManager.score) out of \(triviaManager.length)")
                
                Button {
                    Task.init {
                        await triviaManager.fetchTrivia()
                    }
                } label: {
                    PrimaryButton(text: "Play again")
                }
            }
            .foregroundColor(Color("AccentColor"))
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BGColor"))
            .navigationBarHidden(true)
        } else {
            QuestionView()
                .environmentObject(triviaManager)
        }
    }
}

struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
            .environmentObject(TriviaManager(difficulty: "", category: ""))
    }
}
