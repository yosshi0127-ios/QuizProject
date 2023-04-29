//
//  HistoryInfoModel.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

struct HistoryInfoModel: Equatable {
        
    var id: String = NSUUID().uuidString
    /// 日時
    var date = Date()
    /// 挑戦自体のジャンル
    var genre: String = ""
    
    /// 各問題の情報
    var problems = [ProblemModel]()
    
    init() {}
    
    init(genre: String, problems: [ProblemModel]) {
        self.genre = genre
        self.problems = problems
    }
    
    /// HistoryInfoRealmModelからHistoryInfoModelに変換
    init(historyInfoRealmModel: HistoryInfoRealmModel) {
        self.id = historyInfoRealmModel.id
        self.date = historyInfoRealmModel.date
        self.genre = historyInfoRealmModel.genre
        
        var problems = [ProblemModel]()
        for realmProblem in historyInfoRealmModel.problems {
            let localRealmProblem = ProblemModel(problemRealmModel: realmProblem)
            problems.append(localRealmProblem)
        }
        self.problems = problems
    }
    
    /// HistoryInfoTableからHistoryInfoModelに変換
    init(historyInfoTable: HistoryInfoTable) {
        self.id = historyInfoTable.id
        self.date = historyInfoTable.date
        self.genre = historyInfoTable.genre
        self.problems = historyInfoTable.problems
    }
}

extension HistoryInfoModel {
    
    /// 挑戦日時をStringで返す
    /// - Returns: 挑戦日時秒数も返す
    func getDateStr() -> String {
        return self.date.yyyyMMddHHmmss
    }
    
    ///  ジャンル名を返す
    /// - Returns: ジャンル名
    func getGenre() -> String {
        return self.genre
    }
        
    ///  問題数を返す
    /// - Returns: 問題数
    func getProblemNumber() -> Int {
        return self.problems.count
    }
    
    ///　正解数を返す
    /// - Returns: 正解数
    func getProblemzAnswersNumber() -> Int {
        var count = 0
        for problem in self.problems {
            count += problem.isCorrect == true ? 1 : 0
        }
        return count
    }
    
    ///　正答率を返す
    /// - Returns: 正答率
    func getAccuracyRate() -> Int {
        return Int(Float(self.getProblemzAnswersNumber()) / Float(self.getProblemNumber()) * 100)
    }
}

struct ProblemModel: Codable, Equatable {
    
    /// 問題ID
    var id: Int = 0
    /// 問題文
    var question: String = ""
    /// 択一選択なのか複数選択なのか
    var multipleCorrectAnswers: String = ""
    /// 選択肢の文字列
    var answers: AnswersModel?
    /// 回答状態
    var userAnswer: CorrectAnswersModel?
    /// 正答
    var correctAnswer: CorrectAnswersModel?
    /// 正解であったか否か
    var isCorrect: Bool = false
    /// 正解の解答文
    var explanation: String?
    
    init() {}
                
    /// ProblemRealmModelをProblemModelに変換
    init(problemRealmModel: ProblemRealmModel) {
        self.id = problemRealmModel.id
        self.question = problemRealmModel.question
        self.multipleCorrectAnswers = problemRealmModel.multipleCorrectAnswers
        self.answers = AnswersModel(answersRealmModel: problemRealmModel.answers!)
        self.userAnswer = CorrectAnswersModel(correctAnswersRealmModel: problemRealmModel.userAnswer!)
        self.correctAnswer = CorrectAnswersModel(correctAnswersRealmModel: problemRealmModel.correctAnswer!)
        self.isCorrect = problemRealmModel.isCorrect
        self.explanation = problemRealmModel.explanation
    }
    
    ///  QuizDataとUserが選んだ選択肢と正解かどうかを受け取り初期化する
    /// - Parameters:
    ///   - quizData: QuizData
    ///   - userAnswer:  ユーザーが選んだ選択肢情報
    ///   - isCorrect: 正解かどうか
    init(quizData: QuizData, userAnswer: CorrectAnswers, isCorrect: Bool) {
        // 問題ID
        self.id = quizData.id
        // 問題文
        self.question = quizData.question
        // 択一選択なのか複数選択なのか
        self.multipleCorrectAnswers = quizData.multipleCorrectAnswers
        // 選択肢の文字列
        self.answers = AnswersModel(answers: quizData.answers)
        // 回答状態
        self.userAnswer = CorrectAnswersModel(correctAnswers: userAnswer)
        // 正答
        self.correctAnswer = CorrectAnswersModel(correctAnswers: quizData.correctAnswers)
        // 正答であったか否か
        self.isCorrect = isCorrect
        // 正解の解答文
        self.explanation = quizData.explanation
    }
}

extension ProblemModel {
    
    /// 　問題文を返す
    /// - Returns: 問題文
    func getIdentificationQuestion() -> String {
        return self.question
    }
        
    /// 　問題が択一か複数かを返す
    /// - Returns: true(複数問題)、false(択一問題)
    func getIdentificationMultipleCorrectAnswers() -> Bool {
        return self.multipleCorrectAnswers == "true" ? true : false
    }
        
    /// 　問題が正解か不正解かを返す
    /// - Returns: true(正解)、false(不正解)
    func getIdentificationIscorrect() -> Bool {
        return self.isCorrect
    }
    
    ///　問題の解説文を返す
    /// - Returns: 解説文
    func getExplanation() -> String? {
        return self.explanation
    }
}

struct AnswersModel: Codable, Equatable {
    // 各選択肢
    var answerA: String?
    var answerB: String?
    var answerC: String?
    var answerD: String?
    var answerE: String?
    var answerF: String?
    
    init(answerA: String? = nil, answerB: String? = nil, answerC: String? = nil, answerD: String? = nil, answerE: String? = nil, answerF: String? = nil) {
        self.answerA = answerA
        self.answerB = answerB
        self.answerC = answerC
        self.answerD = answerD
        self.answerE = answerE
        self.answerF = answerF
    }
    
    /// QuizDatanoから直接初期化できるように
    init(answers: Answers) {
        self.answerA = answers.answerA
        self.answerB = answers.answerB
        self.answerC = answers.answerC
        self.answerD = answers.answerD
        self.answerE = answers.answerE
        self.answerF = answers.answerF
    }
    
    /// AnswersRealmModelをAnswersModelに変換
    init(answersRealmModel: AnswersRealmModel) {
        self.answerA = answersRealmModel.answerA
        self.answerB = answersRealmModel.answerB
        self.answerC = answersRealmModel.answerC
        self.answerD = answersRealmModel.answerD
        self.answerE = answersRealmModel.answerE
        self.answerF = answersRealmModel.answerF
    }
    
    func getAnswersArr() -> [String] {
        var arr = [String]()
        
        if let safeA = self.answerA {
            arr.append(safeA)
        }
        if let safeB = self.answerB {
            arr.append(safeB)
        }
        if let safeC = self.answerC {
            arr.append(safeC)
        }
        if let safeD = self.answerD {
            arr.append(safeD)
        }
        if let safeE = self.answerE {
            arr.append(safeE)
        }
        if let safeF = self.answerF {
            arr.append(safeF)
        }
                
        return arr
    }
}

struct CorrectAnswersModel: Codable, Equatable {
    
    var answerACorrect: Bool = false
    var answerBCorrect: Bool = false
    var answerCCorrect: Bool = false
    var answerDCorrect: Bool = false
    var answerECorrect: Bool = false
    var answerFCorrect: Bool = false
    
    /// QuizDatanoから直接初期化できるように
    init(correctAnswers: CorrectAnswers) {
        self.answerACorrect = correctAnswers.answerACorrect
        self.answerBCorrect = correctAnswers.answerBCorrect
        self.answerCCorrect = correctAnswers.answerCCorrect
        self.answerDCorrect = correctAnswers.answerDCorrect
        self.answerECorrect = correctAnswers.answerECorrect
        self.answerFCorrect = correctAnswers.answerFCorrect
    }
    
    /// CorrectAnswersRealmModelをCorrectAnswersModelに変換
    init(correctAnswersRealmModel: CorrectAnswersRealmModel) {
        self.answerACorrect = correctAnswersRealmModel.answerACorrect
        self.answerBCorrect = correctAnswersRealmModel.answerBCorrect
        self.answerCCorrect = correctAnswersRealmModel.answerCCorrect
        self.answerDCorrect = correctAnswersRealmModel.answerDCorrect
        self.answerECorrect = correctAnswersRealmModel.answerECorrect
        self.answerFCorrect = correctAnswersRealmModel.answerFCorrect
    }
    
    func getConnectAnswerArr() -> [Bool] {
        var arr = [Bool]()
        arr.append(answerACorrect)
        arr.append(answerBCorrect)
        arr.append(answerCCorrect)
        arr.append(answerDCorrect)
        arr.append(answerECorrect)
        arr.append(answerFCorrect)
        return arr
    }
}


