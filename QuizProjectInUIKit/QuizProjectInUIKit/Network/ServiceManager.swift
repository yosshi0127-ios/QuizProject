//
//  ServiceManager.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import Foundation

struct ServiceManager {

    private var service: Service
    
    init(service: Service = ServiceData()) {
        self.service = service
    }
    
    func getQuiz(category: String, completion: @escaping (Result<[QuizData], Error>) -> Void) {
        service.fetchQuizData(category: category) { (result) in
            completion(result)
        }
    }
}
