//
//  HistoryInfoModel.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation
import RealmSwift

class HistoryInfoRealmModel: BaseRealmModel {
    /// 挑戦自体のジャンル
    @objc dynamic var genre: String = ""
    /// 各問題の情報
    var problems = List<ProblemRealmModel>()
    
    override init() {
        super.init()
    }
        
    /// HistoryInfoModelをHistoryInfoRealmModelに変換
    init(infoModel: HistoryInfoModel) {
        super.init()
        self.id = infoModel.id
        self.date = infoModel.date
        self.genre = infoModel.genre
                
        let problemRealmModel = List<ProblemRealmModel>()
        for problem in infoModel.problems  {
            problemRealmModel.append(ProblemRealmModel(problemModel: problem))
        }
        self.problems.append(objectsIn: problemRealmModel)
    }
}

class ProblemRealmModel: Object {
    /// 問題ID
    @objc dynamic var id: Int = 0
    /// 問題文
    @objc dynamic var question: String = ""
    /// 択一選択なのか複数選択なのか
    @objc dynamic var multipleCorrectAnswers: String = ""
    /// 選択肢の文字列
    @objc dynamic var answers: AnswersRealmModel?
    /// 回答状態
    @objc dynamic var userAnswer: CorrectAnswersRealmModel?
    /// 正答
    @objc dynamic var correctAnswer: CorrectAnswersRealmModel?
    /// 正解であったか否か
    @objc dynamic var isCorrect: Bool = false
    /// 正解の解答文
    @objc dynamic var explanation: String?
    
    override init() {
        super.init()
    }
        
    /// ProblemModelからProblemRealmModelに変換
    init(problemModel: ProblemModel) {
        self.id = problemModel.id
        self.question = problemModel.question
        self.multipleCorrectAnswers = problemModel.multipleCorrectAnswers
        self.answers = AnswersRealmModel(answerModel: problemModel.answers!)
        self.userAnswer = CorrectAnswersRealmModel(correctAnswer: problemModel.userAnswer!)
        self.correctAnswer = CorrectAnswersRealmModel(correctAnswer: problemModel.correctAnswer!)
        self.isCorrect = problemModel.isCorrect
        self.explanation = problemModel.explanation
    }
}

class AnswersRealmModel: Object {
    // 各選択肢
    @objc dynamic var answerA: String?
    @objc dynamic var answerB: String?
    @objc dynamic var answerC: String?
    @objc dynamic var answerD: String?
    @objc dynamic var answerE: String?
    @objc dynamic var answerF: String?
        
    override init() {
        super.init()
    }
    
    /// AnswersModelからAnswersRealmModelに変換
    init(answerModel: AnswersModel) {
        self.answerA = answerModel.answerA
        self.answerB = answerModel.answerB
        self.answerC = answerModel.answerC
        self.answerD = answerModel.answerD
        self.answerE = answerModel.answerE
        self.answerF = answerModel.answerF
    }
}

class CorrectAnswersRealmModel: Object {
    //　回答状態
    @objc dynamic var answerACorrect: Bool = false
    @objc dynamic var answerBCorrect: Bool = false
    @objc dynamic var answerCCorrect: Bool = false
    @objc dynamic var answerDCorrect: Bool = false
    @objc dynamic var answerECorrect: Bool = false
    @objc dynamic var answerFCorrect: Bool = false
    
    override init() {
        super.init()
    }
    
    /// CorrectAnswersModelからCorrectAnswersRealmModelに変換
    init(correctAnswer: CorrectAnswersModel) {
        self.answerACorrect = correctAnswer.answerACorrect
        self.answerBCorrect = correctAnswer.answerBCorrect
        self.answerCCorrect = correctAnswer.answerCCorrect
        self.answerDCorrect = correctAnswer.answerDCorrect
        self.answerECorrect = correctAnswer.answerECorrect
        self.answerFCorrect = correctAnswer.answerFCorrect
    }
}
