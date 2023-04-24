//
//  QuizBrain.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/24.
//

import Foundation


struct QuizBrain {
    
    private(set) var quiz: [QuizData] = []
    
    // ジャンル情報
    var genreBrain = GenreBrain()
    
    /// 現在のクイズ番号
    var guestionNumber = 0
        
    ///  回答済みかどうかを表す
    var answered = false
        
    /// 回答する度格納して、realm保存するときに使用する
    var localProblems = [ProblemModel]()
    
    // MARK: -- Created Method

    mutating func setQuiz(genreType: GenreBrain.GenreType, quiz: [QuizData]) {
        self.quiz = quiz
        
        self.genreBrain.selectedGenreType = genreType
    }
    
    mutating func initialization() {
        self.answered = false
        self.singleSelectedType = nil
        self.multipleSelectedType = []
    }
    
    /// 現在のクイズ番号から問題文の取得を行う
    /// - Returns: 問題文
    func getQuestion() -> String {
        return quiz[guestionNumber].question
    }
    
    ///  全ての答えを返す
    /// - Returns: [Answers.AnswersType : String]
    func getAnswers() -> [String] {
        return quiz[guestionNumber].answers.answersArr!
    }
        
    ///  特定の答えを返す
    /// - Parameter type: Answers.AnswersType
    /// - Returns: String?
    func getAnswerStr(type: Answers.AnswersType) -> String? {
        let answers = quiz[guestionNumber].answers.answersArr![type.rawValue]
        return answers
    }
    
    ///  問題が択一か複数かを取得する
    /// - Returns: true(複数選択), false(択一選択)
    func getMultipleCorrectAnswers() -> Bool {
        return quiz[guestionNumber].multipleCorrectAnswers == "true" ? true : false
    }
    
    /// 正解の解説文を返す、なかったらnil
    /// - Returns: 解説文
    func getExplanation() -> String? {
        return quiz[guestionNumber].explanation
    }
    
    /// 次の問題に移動する
    mutating func nextQuestion() {
        self.guestionNumber += 1
    }
        
    /// 現在の進捗度取得
    /// - Returns:Float 0〜1
    func getProgress() -> Float {
        // 0.1進めておく
        return (Float(self.guestionNumber) / Float(self.quiz.count) + 0.1)
    }
        
    ///  correctAnswersと選択状況が完全一致している場合は正解とする、またrealmObjectを保持する
    /// - Returns: true(正解), false(不正解)
    mutating func isCorrectAnswers() -> Bool? {
        
        self.answered = true
        
        // 正解を取得
        let correctAnswers = quiz[guestionNumber].correctAnswers
        
        // ユーザーの正解を比べるために用意
        var userAnswers = CorrectAnswers()

        // 選択した答えを取得、保持
        var types = [Answers.AnswersType]()
        if self.getMultipleCorrectAnswers() {
            // 複数
            for type in self.multipleSelectedType {
                types.append(type)
            }
        } else {
            
            guard let safeSingleSelectedType = singleSelectedType else {
                // 択一問題の場合で、答えを選択していないのに確定するボタンを押下した時の制御用
                return nil
            }
            // 択一
            types.append(safeSingleSelectedType)
        }
        
        // 選択した答えを反映する
        for type in types {
            switch type {
            case .answerA: userAnswers.answerACorrect = true
            case .answerB: userAnswers.answerBCorrect = true
            case .answerC: userAnswers.answerCCorrect = true
            case .answerD: userAnswers.answerDCorrect = true
            case .answerE: userAnswers.answerECorrect = true
            case .answerF: userAnswers.answerFCorrect = true
            }
        }

        // 取得した正解と、ユーザーの選択した答えが完全一致かどうか判断する
        let isCorrect = correctAnswers == userAnswers ? true : false
        
        // RealmObjectを生成ローカルに保持しておく
        self.localRealmSave(userAnswer: userAnswers, isCorrect: isCorrect)
        
        return isCorrect
    }

    // MARK: -- Cell Update
    
    // 択一の場合の保持用
    var singleSelectedType: Answers.AnswersType?

    // 複数の場合の保持用
    var multipleSelectedType: [Answers.AnswersType] = []
    
    mutating func cellPressedUpdataUI(_ cell: ProblemChallengeTableViewCell) {
        
        if self.getMultipleCorrectAnswers() {
            // 複数
            self.multipleProblemPressedUpdataUI(cell)
        } else {
            // 択一
            self.singleProblemPressedUpdataUI(cell)
        }
    }
    
    mutating func singleProblemPressedUpdataUI(_ cell: ProblemChallengeTableViewCell) {
        let type = Answers.AnswersType(rawValue: cell.tag)
        // 択一の場合
        // すでに選択されていて、同じのを選択したら非選択にする
        if type == self.singleSelectedType {
            self.singleSelectedType = nil
            cell.cellSelected = false
            
            // SEを流す
            PlayerBrain.players[.NotSelect]?.playSound()
        } else {
            self.singleSelectedType = type
            cell.cellSelected = true
            
            // SEを流す
            PlayerBrain.players[.AnswerSelect]?.playSound()
        }
    }
    
    mutating func multipleProblemPressedUpdataUI(_ cell: ProblemChallengeTableViewCell) {
        let type = Answers.AnswersType(rawValue: cell.tag)!
        
        // 複数の場合
        leap: if self.multipleSelectedType.count != 0 {
            // 保持しておいた配列から探す
            for (index, safemultipleSelectedCell) in multipleSelectedType.enumerated() {
                
                if safemultipleSelectedCell == type {
                    // すでに選択されていた場合で、同じセルを選択した場合
                    // 保持しておいた配列から削除、色を戻す
                    cell.cellSelected = false
                    self.multipleSelectedType.remove(at: index)
                    // SEを流す
                    PlayerBrain.players[.NotSelect]?.playSound()

                    break leap
                }
            }
            
            // 配列に保持、色変更
            cell.cellSelected = true
            self.multipleSelectedType.append(type)
            
            // SEを流す
            PlayerBrain.players[.AnswerSelect]?.playSound()
        } else {
            // 何も選択してない状態
            // 配列に保持、色変更
            cell.cellSelected = true
            self.multipleSelectedType = [type]
            
            // SEを流す
            PlayerBrain.players[.AnswerSelect]?.playSound()
        }
    }
    
    /// 択一の問題で、cellが選択しているかどうかをBoolで返す
    /// - Returns: true(選択), false(何も選択していない)
    func singleCellSelected() -> Bool {
        return self.singleSelectedType != nil ? true : false
    }
    
    /// 正解か不正解かの画像を表示する
    /// - Parameter cell:ProblemChallengeTableViewCell
    func cellAnsweredUpdateUI(_ cell: ProblemChallengeTableViewCell) {
        let correctAnswers = quiz[guestionNumber].correctAnswers
        let correctA = correctAnswers.answerACorrect
        let correctB = correctAnswers.answerBCorrect
        let correctC = correctAnswers.answerCCorrect
        let correctD = correctAnswers.answerDCorrect
        let correctE = correctAnswers.answerECorrect
        let correctF = correctAnswers.answerFCorrect
        
        let type = Answers.AnswersType(rawValue: cell.tag)!
        switch type {
        case .answerA: cell.correctUpdateUI(correct: correctA)
        case .answerB: cell.correctUpdateUI(correct: correctB)
        case .answerC: cell.correctUpdateUI(correct: correctC)
        case .answerD: cell.correctUpdateUI(correct: correctD)
        case .answerE: cell.correctUpdateUI(correct: correctE)
        case .answerF: cell.correctUpdateUI(correct: correctF)
        }
    }
    
    // MARK: -- Realm Save
    
    /// Userが選んだ選択肢と正解かどうかを受け取り、RealmObjectを生成ローカルに保持しておく
    /// - Parameters:
    ///   - userAnswer: ユーザーが選んだ選択肢情報
    ///   - isCorrect: 正解かどうか
    mutating func localRealmSave(userAnswer: CorrectAnswers, isCorrect: Bool) {
        let problem = ProblemModel(quizData: self.quiz[guestionNumber], userAnswer: userAnswer, isCorrect: isCorrect)
        self.localProblems.append(problem)
    }
    
    /// realmに保持しておいた履歴情報を保存する
    func realmSave() -> HistoryInfoModel {
        let model = HistoryInfoModel(genre: genreBrain.selectedGenreType.rawValue, problems: localProblems)
        
        RepositoryManager().writeAction(model: model)
        
        return model
    }    
}
