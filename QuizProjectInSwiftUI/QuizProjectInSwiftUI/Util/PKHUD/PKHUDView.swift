//
//  PKHUDView.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import SwiftUI
import PKHUD

struct PKHUDView: UIViewRepresentable {
    @Binding var isPresented: Bool
    var HUDContent: HUDContentType
    func makeUIView(context: UIViewRepresentableContext<PKHUDView>) -> UIView {
        return UIView()
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PKHUDView>) {
        if isPresented {
            HUD.show(HUDContent)
        } else {
            HUD.hide()
        }
    }
}
