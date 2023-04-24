//
//  BaseModels.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import Foundation
import RealmSwift

class BaseRealmModel: RealmSwift.Object {
    // UUIDをプライマリキーにする
    @objc dynamic var id: String = NSUUID().uuidString
    /// 日時
    @objc dynamic var date = Date()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
