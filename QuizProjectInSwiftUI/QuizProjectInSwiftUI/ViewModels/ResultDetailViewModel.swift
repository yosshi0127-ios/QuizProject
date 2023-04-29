//
//  ResultDetailViewModel.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation


class ResultDetailViewModel: ProblemViewModel {
    
    var imageName: String {
        return ZundamonManager.shared.answerZundamon(correct: self.dentificationIscorrect).rawValue
    }
    
    func playSound() {
        ZundamonManager.shared.playSoundAnswerZundamon(correct: self.dentificationIscorrect)
    }
}
