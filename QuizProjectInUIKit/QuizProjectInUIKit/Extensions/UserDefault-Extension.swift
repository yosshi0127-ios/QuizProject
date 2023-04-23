//
//  UserDefault-Extension.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import UIKit

public extension UserDefaults {
    
    struct key: Hashable, RawRepresentable, ExpressibleByStringLiteral {
        
        public var rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        public init(stringLiteral value: StringLiteralType) {
            self.rawValue = value
        }
    }
    
    func set<T>(_ value: T?, forKey key: key) {
        set(value, forKey: key.rawValue)        
    }
    
    func bool(forkey key: key) -> Bool {
        return bool(forKey: key.rawValue)
    }

    func string(forkey key: key) -> String? {
        return string(forKey: key.rawValue)
    }
    
}

public extension UserDefaults.key {
    
    static let soundFlg: UserDefaults.key = "soundFlg"
}
