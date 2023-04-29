//
//  Date-Extension.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

extension Date {
    var yyyyMMddHHmmss: String {
        return DateFormatter.yyyyMMddHHmmss.string(from: self)
    }
}
