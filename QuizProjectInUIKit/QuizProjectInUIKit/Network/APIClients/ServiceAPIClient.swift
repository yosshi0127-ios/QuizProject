//
//  ServiceAPIError.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import Foundation
import Alamofire


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
    
    func getQuiz(limit: Int = 10, category: String = "All", completion: @escaping(Result<[QuizData], Error>) -> Void) {

        var urlStr = "\(self.baseURL)&limit=\(limit)"
                
        if category != "All" {
            urlStr += "&category=\(category)"
        }

        let url = URL(string: urlStr)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        AF.request(request).response(queue: .global()) { response in
            guard let data = response.data else {
                completion(.failure(ServiceAPIError.noData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let json = try jsonDecoder.decode([QuizData].self, from: data)

                
                // ValidationCheck
                // 指定したlimitと等しいかチェックする
                if !self.quizDataValidationCheckLimit(limit: limit, json: json) {
                    completion(.failure(ServiceAPIError.noLimit))
                    return
                }
                // 答えのいずれかはtrueであることをチェックする
                if !self.quizDataValidationCheckinvalidData(json: json) {
                    completion(.failure(ServiceAPIError.invalidData))
                    return
                }
                
                completion(.success(json))
            } catch {
                print("getQuestionsDecodeFailed: \(error)")
                completion(.failure(error))
            }
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
