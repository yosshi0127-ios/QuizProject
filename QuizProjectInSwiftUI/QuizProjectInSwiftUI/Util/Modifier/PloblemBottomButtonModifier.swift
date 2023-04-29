//
//  PloblemBottomButtonModifier.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import SwiftUI

struct PloblemBottomButtonModifier: ViewModifier {
   
    var foregroundColor: Color = .black
    var frameMaxWidth: CGFloat = .infinity
    var minHeight: CGFloat = 48
    var backgroundColor: Color
    var cornerRadius: CGFloat = 20
    var paddingEdges: Edge.Set = .horizontal
    var paddingLength: CGFloat = 18
    var hidden: Bool
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundColor)
            .frame(maxWidth: frameMaxWidth, minHeight: minHeight)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .padding(paddingEdges, paddingLength)
            .hidden(hidden)
    }
}
