//
//  ContentView.swift
//  TriviaGameDemo
//
//  Created by 전수민 on 2023/07/24.
//

import SwiftUI

struct ContentView: View {
    @State var selectDifficulty = Difficulties.any
    enum Difficulties: String, CaseIterable, Identifiable {
        case any, easy, midium, hard
        var id: Self { self }
    }
    
    @State var selectCategory = Categories.any
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
    
    @State var selectType = Types.any
    enum Types: String, CaseIterable, Identifiable {
        case any = "Any",
             multiple = "Multiple Choice",
             trueOrFalse = "True or False"
        
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
                    Picker("Difficulty", selection: $selectDifficulty) {
                        ForEach(Difficulties.allCases) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    
                    Picker("Category", selection: $selectCategory) {
                        ForEach(Categories.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    
                    Picker("Type", selection: $selectType) {
                        ForEach(Types.allCases) {
                            Text($0.rawValue)
                        }
                    }
                }
                .foregroundColor(Color("AccentColor"))
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                .frame(height: 200)
                
                NavigationLink {
                    TriviaView()
                        .environmentObject(TriviaManager(difficulty: selectDifficulty.rawValue, category: selectCategory.rawValue, type: selectType.rawValue))
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
