//
//  ContentView.swift
//  TriviaGameDemo
//
//  Created by 전수민 on 2023/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 20) {
                Text("Trivia Game")
                    .lilacTitle()
                
                Text("Are you ready to test out your trivia skills?")
                    .foregroundColor(Color("AccentColor"))
            }
            
            PrimaryButton(text: "Let's go!")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color(red: 200/255, green: 250/255, blue: 180/255))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
