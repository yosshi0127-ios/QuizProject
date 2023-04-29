//
//  SeviceDataRepository.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation


struct ServiceDataRepository: Service {
    
    private let serviceAPIClient = ServiceAPIClient()
    
    func fetchGetQuiz(category: String) async throws -> [QuizData] {
        try await serviceAPIClient.getQuiz(category: category)
    }
}
