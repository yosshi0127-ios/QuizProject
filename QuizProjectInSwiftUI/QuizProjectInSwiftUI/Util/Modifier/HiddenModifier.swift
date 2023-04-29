//
//  HiddenModifier.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import SwiftUI

struct HiddenModifier : ViewModifier {
    let hidden:Bool
    @ViewBuilder
    func body(content: Content) -> some View {
        if hidden {
            EmptyView()
        } else {
            content
        }
    }
}
