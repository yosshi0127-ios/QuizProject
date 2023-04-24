//
//  Date-Extension.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import Foundation

extension Date {
    var yyyyMMddHHmmss: String {
        return DateFormatter.yyyyMMddHHmmss.string(from: self)
    }
}
