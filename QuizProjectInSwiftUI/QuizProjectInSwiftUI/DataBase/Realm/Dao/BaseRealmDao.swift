//
//  BaseDao.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation
import RealmSwift

class BaseRealmDao <T : BaseRealmModel> {

    let realm: Realm
    
    init() {
        self.realm = try! Realm()
    }
    
    ///  書き込む為の処理
    func writeAction<T: Object>(model: T) {
        // Realmに保存
        do {
            try self.realm.write {
                self.realm.add(model)
                print(realm.objects(T.self))
            }
        } catch {
            print(error)
        }
    }
        
    func getAllAction() -> Results<T>  {
        return realm.objects(T.self)
    }
}



