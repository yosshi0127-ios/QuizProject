//
//  MockRepository.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/25.
//

import Foundation

struct MockRepository: Repository {
    typealias ObjectType = HistoryInfoModel
    
    let repos: [HistoryInfoModel]
    
    func writeAction(model: HistoryInfoModel) { }
    
    func getAllData() -> [HistoryInfoModel] {
        return repos
    }
}
