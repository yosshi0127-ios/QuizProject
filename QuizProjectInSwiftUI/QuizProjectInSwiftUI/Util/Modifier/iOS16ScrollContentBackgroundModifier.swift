//
//  iOS16ScrollContentBackground.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import SwiftUI

struct iOS16ScrollContentBackgroundModifier: ViewModifier {
    
    var visibility: Visibility
    
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(visibility)
        } else {
            content
        }
    }
}

