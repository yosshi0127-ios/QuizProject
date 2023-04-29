//
//  TopViewModel.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/28.
//

import Foundation

class TopViewModel: ObservableObject {
        
    @Published var showAlert = false
    
    init() {
        showAlert = !UserDefaults.standard.bool(forkey: .soundFlg)
    }
        
    func setUserDefault() {
        UserDefaults.standard.set(true, forKey: .soundFlg)
    }
}
