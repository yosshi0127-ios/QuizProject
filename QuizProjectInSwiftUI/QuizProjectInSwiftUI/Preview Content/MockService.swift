//
//  MockService.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

struct MockService: Service {
    let repos: [QuizData]
    let error: Error?
    
    init(repos: [QuizData], error: Error? = nil) {
        self.repos = repos
        self.error = error
    }
    
    func fetchGetQuiz(category: String) async throws -> [QuizData] {
        if let error = error {
            throw error
        }
        
        return repos
    }
    
}
