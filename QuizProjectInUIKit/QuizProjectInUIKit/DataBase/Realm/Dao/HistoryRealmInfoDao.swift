//
//  HistoryInfoDao.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import Foundation
import RealmSwift
import Realm

class HistoryRealmInfoDao: BaseRealmDao<HistoryInfoRealmModel> {
    
    static let shared = HistoryRealmInfoDao()
    
    override func writeAction<T>(model: T) where T : RealmSwiftObject {
        super.writeAction(model: model)
    }
    
    override func getAllAction() -> Results<HistoryInfoRealmModel> {
        return super.getAllAction()
    }
}
