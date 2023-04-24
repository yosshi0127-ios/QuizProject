//
//  DatabaseHelper.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/24.
//

import Foundation
import GRDB

class SQLiteHelper {
        
    private struct Const {
        static let dbFileName = "database.db"
        
        static let dbFilePath = NSTemporaryDirectory() + dbFileName
    }
    
    init() {
        self.createDatabase()
    }
    
    func inDatabase(_ block: (Database) throws -> Void) -> Bool {
        do {
            let dbQueue = try DatabaseQueue(path: Const.dbFilePath)
            try dbQueue.inDatabase(block)
        } catch let error {
            print("Database Error: \(error.localizedDescription)")
            return false
        }
        
        return true
    }
    
    private func createDatabase() {
        if FileManager.default.fileExists(atPath: Const.dbFilePath) {
            return
        }
        
        let result = inDatabase { (db) in
            
            do {
                try HistoryInfoTable.create(db)
                
            } catch let error {
                print("Database Tablecreate: \(error.localizedDescription)")
            }
        }
        
        if !result {
            print("create failed for Database")
            
            do {
                try FileManager.default.removeItem(atPath: Const.dbFileName)
            } catch {
                print("remove failed for Database")
            }
        }
    }
}
