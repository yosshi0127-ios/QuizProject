//
//  PKHUDViewModifier.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import SwiftUI
import PKHUD

struct PKHUDViewModifier<Parent: View>: View {
    @Binding var isPresented: Bool
    var HUDContent: HUDContentType
    var parent: Parent
    var body: some View {
        ZStack {
            parent
            if isPresented {
                PKHUDView(isPresented: $isPresented, HUDContent: HUDContent)
            }
        }
    }
}
