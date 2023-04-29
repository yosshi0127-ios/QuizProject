//
//  PKHUD.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import SwiftUI
import PKHUD

extension View {
    public func PKHUD(isPresented: Binding<Bool>, HUDContent: HUDContentType) -> some View {
        PKHUDViewModifier(isPresented: isPresented, HUDContent: HUDContent, parent: self)
    }
}
