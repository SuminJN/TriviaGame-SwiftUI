//
//  ContentView.swift
//  TriviaGameDemo
//
//  Created by 전수민 on 2023/07/24.
//

import SwiftUI

struct ContentView: View {
    @State var selectedDifficulty = Difficulties.any
    enum Difficulties: String, CaseIterable, Identifiable {
        case any, easy, midium, hard
        var id: Self { self }
    }
    
    @State var selectedCategory = Categories.any
    enum Categories: String, CaseIterable, Identifiable {
        case any = "Any",
             GeneralKnowledge = "General Knowledge",
             Books,
             Film,
             Music,
             Computers,
             Mathematics,
             Mythology,
             Sports,
             Geography
        
        var id: Self { self }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 20) {
                    Text("Trivia Game")
                        .mainTitle()
                    
                    Text("Are you ready to test out your trivia skills?")
                        .foregroundColor(Color("AccentColor"))
                }
                List {
                    Picker("Difficulty", selection: $selectedDifficulty) {
                        ForEach(Difficulties.allCases) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(Categories.allCases) {
                            Text($0.rawValue)
                        }
                    }
                }
                .foregroundColor(Color("AccentColor"))
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                .frame(height: 180)
                
                NavigationLink {
                    TriviaView()
                        .environmentObject(TriviaManager(difficulty: selectedDifficulty.rawValue, category: selectedCategory.rawValue))
                } label: {
                    PrimaryButton(text: "Let's go!")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color("BGColor"))
        }
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
