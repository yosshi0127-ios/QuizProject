//
//  ResultListViewModel.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

class ResultListViewModel: ObservableObject {
    @Published var models = [HistoryInfoModel]()
    
    @Published var selectedModel: HistoryInfoModel? = nil
    
    func setModels() {        
        // realmから取得
        let models = RepositoryManager().getHistoryInfoModels()
        self.models = models.sorted(by: {$0.date.compare($1.date) == .orderedDescending
        })
    }
}
