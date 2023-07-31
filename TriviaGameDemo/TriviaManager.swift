//
//  TriviaManager.swift
//  TriviaGameDemo
//
//  Created by 전수민 on 2023/07/26.
//

import Foundation
import SwiftUI

class TriviaManager: ObservableObject {
    private(set) var trivia: [Trivia.Result] = []
    @Published private(set) var length = 0
    @Published private(set) var index = 0
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelected = false
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices = [Answer]()
    @Published private(set) var progress: CGFloat = 0.00
    @Published private(set) var score = 0
    @Published private(set) var difficulty: String = ""
    @Published private(set) var categoryNumber: Int = 0
    
    init(difficulty: String, category: String) {
        self.difficulty = difficulty
        
        setCategoryNumber(category: category)
        
        Task.init {
            await fetchTrivia()
        }
    }
    
    func fetchTrivia() async {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10" + (difficulty == "any" ? "" : "&difficulty=\(difficulty)") + "&category=\(categoryNumber)") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(Trivia.self, from: data)
            
            DispatchQueue.main.async {
                self.index = 0
                self.score = 0
                self.progress = 0.00
                self.reachedEnd = false
                self.trivia = decodedData.results
                self.length = self.trivia.count
                self.setQuestion()
            }
        } catch {
            print("Error fetching trivia: \(error)")
        }
    }
    
    func goToNextQuestion() {
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            reachedEnd = true
        }
    }
    
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double(index + 1) / Double(length) * 350)
        
        if index < length {
            let currentTriviaQuestion = trivia[index]
            question = currentTriviaQuestion.formattedQuestion
            answerChoices = currentTriviaQuestion.answers
        }
    }
    
    func selectAnswer(answer: Answer) {
        answerSelected = true
        
        if answer.isCorrect {
            score += 1
        }
    }
    
    func setCategoryNumber(category: String) {
        switch category {
        case "General Knowledge":
            categoryNumber = 9
        case "Books":
            categoryNumber = 10
        case "Film":
            categoryNumber = 11
        case "Music":
            categoryNumber = 12
        case "Musicals & Theatres":
            categoryNumber = 13
        case "Television":
            categoryNumber = 14
        case "Video Games":
            categoryNumber = 15
        case "Board Games":
            categoryNumber = 16
        case "Science & Nature":
            categoryNumber = 17
        case "Computers":
            categoryNumber = 18
        case "Mathematics":
            categoryNumber = 19
        case "Mythology":
            categoryNumber = 20
        case "Sports":
            categoryNumber = 21
        case "Geography":
            categoryNumber = 22
        default:
            categoryNumber = 0
        }
    }
}
