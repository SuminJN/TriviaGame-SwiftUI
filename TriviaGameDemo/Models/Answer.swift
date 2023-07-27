//
//  Answer.swift
//  TriviaGameDemo
//
//  Created by 전수민 on 2023/07/24.
//

import Foundation

struct Answer: Identifiable {
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
}
