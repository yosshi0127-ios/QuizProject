//
//  RepositoryManager.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

class RepositoryManager<RepositoryType: Repository>: NSObject where RepositoryType.ObjectType == HistoryInfoModel
{
    private var repository: RepositoryType
    
    init(repository: RepositoryType = RepositoryHistoryInfoModel()) {
        self.repository = repository
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func writeAction(model: HistoryInfoModel) {
        repository.writeAction(model: model)
    }
    
    func getHistoryInfoModels() -> [HistoryInfoModel] {
        return repository.getAllData()
    }
}


