//
//  ResultViewModel.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

class ResultViewModel: HistoryInfoViewModel {
    
    var selectedProblem: ProblemModel?
    
    var imageName: String {
        return ZundamonManager.shared.accuracyRateZundamon(accuracyRate: self.accracyRate).rawValue
    }
    
    func playSound() {
        self.accuracyRatePlaySound()
    }    
}
