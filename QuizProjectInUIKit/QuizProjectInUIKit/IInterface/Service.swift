//
//  Service.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import Foundation

protocol Service {
    func fetchQuizData(category: String, completion: @escaping (Result<[QuizData], Error>) -> Void)
}

