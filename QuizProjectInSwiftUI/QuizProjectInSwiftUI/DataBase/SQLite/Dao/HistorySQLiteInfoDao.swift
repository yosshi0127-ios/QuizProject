//
//  HistorySQLiteInfoDao.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

class HistorySQLiteInfoDao {
    
    static let shared = HistorySQLiteInfoDao()
    
    private let helper = SQLiteHelper()
    
    func writeAction(historyInfoTable: HistoryInfoTable) {
        
        let _ = helper.inDatabase { (db) in

            do {
                try historyInfoTable.insert(db)
            } catch {
                print("write Error: SQLite \(error)")
            }
        }
    }
        
    func getAllAction() -> [HistoryInfoTable] {
        
        var historyInfoTables = [HistoryInfoTable]()
        
        let _ = helper.inDatabase { (db) in
            do {
                let localHistoryInfoTables = try HistoryInfoTable.fetchAll(db)
                historyInfoTables = localHistoryInfoTables
            } catch {
                print("get Error: SQLite \(error)")
            }
        }
        
        return historyInfoTables
    }
}
