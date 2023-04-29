//
//  Service.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

protocol Service {
    func fetchGetQuiz(category: String) async throws -> [QuizData]
}

