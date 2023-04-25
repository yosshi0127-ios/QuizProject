//
//  MockServiceRepository.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/25.
//

import Foundation

struct MockService: Service {
    let repos: [QuizData]
    let error: Error?
        
    func fetchQuizData(category genreType: String, completion: @escaping (Result<[QuizData], Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        completion(.success(repos))
    }
}

