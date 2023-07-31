//
//  ContentView.swift
//  TriviaGameDemo
//
//  Created by 전수민 on 2023/07/24.
//

import SwiftUI

struct ContentView: View {
//    @StateObject var triviaManager = TriviaManager(trueOrFalse: true)
    @State var selectedDifficulty = Difficulties.easy
    enum Difficulties: String, CaseIterable, Identifiable {
        case easy, midium, hard
        var id: Self { self }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                VStack(spacing: 20) {
                    Text("Trivia Game")
                        .mainTitle()
                    
                    Text("Are you ready to test out your trivia skills?")
                        .foregroundColor(Color("AccentColor"))
                }
                
                Picker("Difficulty", selection: $selectedDifficulty) {
                    ForEach(Difficulties.allCases) {
                        Text($0.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                NavigationLink {
                    TriviaView()
                        .environmentObject(TriviaManager(difficulty: selectedDifficulty.rawValue))
                } label: {
                    PrimaryButton(text: "Let's go!")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color("BGColor"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
