//
//  QuizBrain.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation


struct QuizBrain {
    private var quiz: [QuizData] = []

    private var genreBrain = GenreBrain()
    
    /// 現在のクイズ番号
    private var guestionNumber = 0
    
    /// 回答する度格納して、realm保存するときに使用する
    private var localProblems = [ProblemModel]()
    
    // MARK: -- Created Method
    
    mutating func setQuiz(genreType: GenreBrain.GenreType, _ quiz: [QuizData]) {
        self.quiz = quiz
        
        self.genreBrain.selectedGenreType = genreType
    }
    
    mutating func initialization() {
        self.singleSelectedType = nil
        self.multipleSelectedType = []
    }
                
    /// 現在のクイズ番号から問題文の取得を行う
    /// - Returns: String
    func getQuestion() -> String {
        return quiz[guestionNumber].question
    }
    
    ///  全ての答えを返す
    /// - Returns: [Answers.AnswersType : String]
    func getAnswers() -> [PloblemAnswer] {
        return quiz[guestionNumber].answers.answersArr!
    }
    
    ///  問題の正解か不正解を返す
    /// - Returns: 問題の正解
    func getCorrectAnswers() -> [Answers.AnswersType: Bool] {
        return quiz[guestionNumber].correctAnswers.correctAnswersArr!
    }
        
    ///  問題が択一か複数かを取得する
    /// - Returns: true(複数選択), false(択一選択)
    func getMultipleCorrectAnswers() -> Bool {
        return quiz[guestionNumber].multipleCorrectAnswers == "true" ? true : false
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
    
    /// 次の問題が最後の問題に達しているかどうかチェックする
    /// - Returns:  true(最後問題), false(最後の問題ではない)
    func checkLastQuestion() -> Bool {
        if self.quiz.count > (self.guestionNumber + 1) {
            return false
        } else {
            return true
        }
    }
    
    /// 正解の解説文を返す、なかったらnil
    /// - Returns: 解説文
    func getExplanation() -> String? {
        return quiz[guestionNumber].explanation
    }
    
    /// correctAnswersと選択状況が完全一致している場合は正解とする、またrealmObjectを保持する
    /// - Returns: true(正解), false(不正解)
    mutating func isCorrectAnswers() -> Bool? {
        
        // 正解を取得
        var correctAnswers = quiz[guestionNumber].correctAnswers
        // ** ユーザーの答えと合わせるために、必要ないデータはnilにする
        correctAnswers.correctAnswersArr = nil
        
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
    
    // MARK: -- typeUpdate
    
    // 択一の場合の保持用
    var singleSelectedType: Answers.AnswersType?
    // 複数の場合の保持用
    var multipleSelectedType: [Answers.AnswersType] = []
        
    mutating func singleSelectedTypeUpdate(selectType: Answers.AnswersType) -> (Answers.AnswersType?, Bool) {
        
        var previousType: Answers.AnswersType?
        var selected = false
        
        // すでに選択されていて、同じのを選択したら非表示にする
        if selectType == self.singleSelectedType {
            self.singleSelectedType = nil
        } else {
            if self.singleSelectedType != nil {
                // 前のタイプをセットして返す
                previousType = singleSelectedType
            }
            self.singleSelectedType = selectType
            
            selected.toggle()
        }
        
        return (previousType, selected)
    }
    
    mutating func multiplaSelectedTypeUpdate(selectType: Answers.AnswersType) -> Bool {
        // 複数
        if self.multipleSelectedType.count != 0 {
            for (index, multipleSelectedType) in self.multipleSelectedType.enumerated() {
                if multipleSelectedType == selectType {
                    self.multipleSelectedType.remove(at: index)

                    return false
                }
            }
        }

        self.multipleSelectedType.append(selectType)
        
        return true
    }
        
    // MARK: -- Realm Usage
    
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

