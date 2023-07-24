//
//  Extensions.swift
//  TriviaGameDemo
//
//  Created by 전수민 on 2023/07/24.
//

import Foundation
import SwiftUI

extension Text {
    func lilacTitle() -> some View {
        self.font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color("AccentColor"))
    }
}
