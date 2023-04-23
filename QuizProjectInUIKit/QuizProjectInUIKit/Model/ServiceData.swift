//
//  ServiceData.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import Foundation

struct ServiceData: Service {
    func fetchQuizData(category: String, completion: @escaping (Result<[QuizData], Error>) -> Void) {
        ServiceAPIClient().getQuiz(category: category) { (result) in
            completion(result)
        }
    }
}
