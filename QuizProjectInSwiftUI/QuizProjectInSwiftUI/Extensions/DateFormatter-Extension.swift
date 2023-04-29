//
//  DateFormatter-Extension.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

extension DateFormatter {
    
    static var yyyyMMddHHmmss: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current

        return dateFormatter
    }
    
}
