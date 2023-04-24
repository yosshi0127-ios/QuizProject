//
//  RepositoryHistoryInfoModel.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/24.
//

import Foundation

struct RepositoryHistoryInfoModel: Repository {
    typealias ObjectType = HistoryInfoModel
    
    func writeAction(model: HistoryInfoModel) {
        
        // SettingsのdataBaseTypeによってDBを別ける
        switch Settings.shared.getDatabaseType() {
        case .realm:
            // HistoryInfoModelからHistoryInfoRealmModelに変換
            let realmModel = HistoryInfoRealmModel(infoModel: model)
            
            HistoryRealmInfoDao.shared.writeAction(model: realmModel)
            
        case .sqLite:
            // HistoryInfoModelからHistoryInfoTableに変換
            let historyInfoTable = HistoryInfoTable(historyInfoModel: model)
            
            HistorySQLiteInfoDao.shared.writeAction(historyInfoTable: historyInfoTable)
        }
    }
        
    func getAllData() -> [HistoryInfoModel] {

        var historyInfoModel = [HistoryInfoModel]()
        
        // SettingsのdataBaseTypeによってDBを別ける
        switch Settings.shared.getDatabaseType() {
        case .realm:
            let historyInfoRealmModels = HistoryRealmInfoDao.shared.getAllAction()

            // HistoryInfoRealmModelからHistoryInfoModelに変換
            historyInfoRealmModels.forEach { (model) in
                historyInfoModel.append(HistoryInfoModel(historyInfoRealmModel: model))
            }
        case .sqLite:
            let historyInfoTables = HistorySQLiteInfoDao.shared.getAllAction()
            
            // historyInfoTablesからHistoryInfoModelに変換
            historyInfoTables.forEach {(model) in
                historyInfoModel.append(HistoryInfoModel(historyInfoTable: model))
            }
        }
        
        return historyInfoModel
    }
}
