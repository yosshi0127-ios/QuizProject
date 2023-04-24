//
//  Repository.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/24.
//

import Foundation

protocol Repository {
    associatedtype ObjectType: Any
    func writeAction(model: ObjectType)
    func getAllData() -> [ObjectType]
}

