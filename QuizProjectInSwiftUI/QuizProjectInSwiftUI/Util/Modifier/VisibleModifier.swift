//
//  VisibleModifier.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import SwiftUI

struct VisibleModifier : ViewModifier {
    let visible:Bool
    @ViewBuilder
    func body(content: Content) -> some View {
        if visible == false {
            content.hidden()
        } else {
            content
        }
    }
}
