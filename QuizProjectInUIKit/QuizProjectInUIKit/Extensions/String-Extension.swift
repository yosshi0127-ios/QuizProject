//
//  String-Extension.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import Foundation

extension String {
    
    func toBool() -> Bool? {
        
        switch self {
        case "true":
            return true

        case "false":
            return false
        default:
            return nil
        }
    }
}

