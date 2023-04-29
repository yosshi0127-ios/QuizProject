//
//  ServiceAPIClient.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

enum ServiceAPIError: Error {
    // Dataが空
    case noData
    // リミットと数が合わない
    case noLimit
    // 無効なデータ
    case invalidData
}

struct ServiceAPIClient {
    let baseURL = "https://quizapi.io/api/v1/questions?apiKey=b2IhHAAFVvPIeuAgq31uFlZ0dWjYLEgIFzp2CUHa"
    
    func getQuiz(limit: Int = 10, category: String = "All") async throws -> [QuizData]  {
        
        var urlStr = "\(self.baseURL)&limit=\(limit)"
        
        if category != "All" {
            urlStr += "&category=\(category)"
        }
        
        let url = URL(string: urlStr)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            
            let json = try jsonDecoder.decode([QuizData].self, from: data)
            
            // ValidationCheck
            // 指定したlimitと等しいかチェックする
            if !self.quizDataValidationCheckLimit(limit: limit, json: json) {
                throw ServiceAPIError.noLimit
            }
            // 答えのいずれかはtrueであることをチェックする
            if !self.quizDataValidationCheckinvalidData(json: json) {
                throw ServiceAPIError.invalidData
            }
            
            return json
        } catch {
            print("getQuestionsDecodeFailed: \(error)")
            throw error
        }
    }
    
    func quizDataValidationCheckLimit(limit: Int, json: [QuizData]) -> Bool {
        // 指定したlimitと等しいかチェックする
        if limit != json.count {
            return false
        }
        return true
    }
    
    func quizDataValidationCheckinvalidData(json: [QuizData]) -> Bool {
        // quizData全てチェック
        for quizData in json {
            // 択一問題の場合はチェック
            if !quizData.multipleCorrectAnswers.toBool()! {
                if !quizData.correctAnswers.checkCorrectAnswers() {
                    return false
                }
            }
        }
        
        return true
    }
}

