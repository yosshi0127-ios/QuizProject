//
//  ServiceManager.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

struct ServiceManager {
    
    private let serviceRepository: Service
    
    init(serviceRepository: Service = ServiceDataRepository()) {
        self.serviceRepository = serviceRepository
    }
    
    func loadQuizData(_ category: String) async throws -> [QuizData] {
        try await serviceRepository.fetchGetQuiz(category: category)
    }
}
