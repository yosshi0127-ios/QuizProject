//
//  View-Extension.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import SwiftUI

extension View {
    
    func iOS16ScrollContentBackground(_ visibility: Visibility) -> some View {
        modifier(iOS16ScrollContentBackgroundModifier(visibility: visibility))
    }
    
    func visible(_ visible:Bool) -> some View {
        modifier(VisibleModifier(visible: visible))
    }
    
    func hidden(_ hidden:Bool) -> some View {
        modifier(HiddenModifier(hidden: hidden))
    }
}

