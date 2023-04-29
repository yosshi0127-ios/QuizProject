//
//  AnimationImageViewModel.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation
import SwiftUI

class AnimationImageViewModel: ObservableObject {
    private var timer: Timer!
    
    private var imageNames: [String]
    
    private var index = 0
    
    @Published var imageName: String
    @Published var flag = true
    
    init(imageNames: [String]) {
        self.imageNames = imageNames
        self.imageName = imageNames[index]
    }
    
    func startTimer() {
        self.timer?.invalidate()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { _ in
            self.index = self.index < self.imageNames.count - 1 ? self.index + 1 : 0
            
            self.animation()
        })
    }
        
    private func animation() {
        withAnimation {
            let newImageName = imageNames[index]
            self.flag.toggle()
            
            
            DispatchQueue.global().async {
                Thread.sleep(forTimeInterval: 0.2)
                
                DispatchQueue.main.async {
                    self.imageName = newImageName
                    self.flag.toggle()
                }
            }
        }
    }    
}
