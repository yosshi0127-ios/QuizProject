//
//  HistoryInfoTable.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation
import GRDB

struct HistoryInfoTable: Codable, FetchableRecord, PersistableRecord {
    
    var id: String = NSUUID().uuidString
    /// 日時
    var date = Date()
    /// 挑戦自体のジャンル
    var genre: String = ""
    
    /// 各問題の情報
    var problems = [ProblemModel]()
    
    init() {}
    
    /// HistoryInfoModelからHistoryInfoTableに変換
    init(historyInfoModel: HistoryInfoModel) {
        self.id = historyInfoModel.id
        self.date = historyInfoModel.date
        self.genre = historyInfoModel.genre
        self.problems = historyInfoModel.problems
    }
    
    static var databaseTableName: String {
        return "HISTORY_INFO"
    }
    
    static func create(_ db: Database) throws {
        try db.create(table: databaseTableName, body: { (t: TableDefinition) in
            t.column("id", .text).primaryKey()
            t.column("date", .date).notNull()
            t.column("genre", .text).notNull()
            t.column("problems", .any).notNull()
        })
    }
}


