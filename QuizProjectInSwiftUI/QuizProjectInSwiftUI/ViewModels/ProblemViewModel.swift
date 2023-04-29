//
//  ProblemViewModel.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

class ProblemViewModel {
    private var problemModel: ProblemModel
    
    init(problemModel: ProblemModel) {
        self.problemModel = problemModel
    }
    
    /// 選択肢の文字列を取得
    var answers: [String] {
        return problemModel.answers?.getAnswersArr() ?? [String]()
    }

    /// 回答状態を取得
    var userAnswer: [Bool] {
        return problemModel.userAnswer?.getConnectAnswerArr() ?? [Bool]()
    }
    
    /// 正答を取得
    var correctAnswer: [Bool] {
        return problemModel.correctAnswer?.getConnectAnswerArr() ?? [Bool]()
    }
    
    /// 問題文
    var identificationQuestion: String {
        return problemModel.getIdentificationQuestion()
    }
    
    /// 問題が択一か複数かどうか
    var multipleCorrectAnswers: Bool {
        return problemModel.getIdentificationMultipleCorrectAnswers()
    }
        
    /// 問題が正解か不正解かどうか
    var dentificationIscorrect: Bool {
        return problemModel.getIdentificationIscorrect()
    }
    
    /// 問題の解説文
    var explanation: String {
        return problemModel.getExplanation() ?? ""
    }
}
