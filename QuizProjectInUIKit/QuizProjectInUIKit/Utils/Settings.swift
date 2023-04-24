//
//  Settings.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/24.
//

import Foundation

enum DataBaseType {
    case realm
    case sqLite
}

class Settings {
      
    static let shared = Settings()
    
    /// ローカルDBの設定
    private let dataBaseType: DataBaseType = .sqLite
        
    ///  ローカルDBの設定Typeを返す
    /// - Returns: realmかsqlite
    func getDatabaseType() -> DataBaseType {
        return dataBaseType
    }
}
