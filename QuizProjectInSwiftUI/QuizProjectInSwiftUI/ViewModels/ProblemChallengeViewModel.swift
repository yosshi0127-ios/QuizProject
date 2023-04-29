//
//  ProblemChallengeViewModel.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation
import SwiftUI

class ProblemChallengeViewModel: ObservableObject {
    private var quizBrain = QuizBrain()
            
    init(genreType: GenreBrain.GenreType, quiz: [QuizData]) {
        quizBrain.setQuiz(genreType: genreType, quiz)
        self.setAnswers()
        self.confirmBtnSetUpControl()
        self.randomZundamonToWorry()
    }

    /// 確定ボタンの表示、非表示制御
    @Published var confirmBtnVisible = false
    /// 確定ボタンの選択、非選択制御(択一問題のみ行う)
    @Published var confirmBtnIsEnabled = true
    
    /// 次へボタンの表示、非表示制御
    @Published var nextBtnHidden = true
    
    /// 結果表示ボタンの表示、非表示制御
    @Published var resultBtnHidden = true
    /// 結果表示ボタンの選択、非選択制御()
    @Published var resultBtnIsEnabled = false
        
    /// クイズが終了かどうかを表す
    @Published var quizFinish = false
    
    /// 正解の解説文の表示、非表示制御
    var explanationHidden = true
    
    /// 回答済みかを表す
    var answerd = false
        
    // 答えの情報を保持しておく為の配列
    @Published var answers = [PloblemAnswer]()

    /// 正解しているかどうか
    var isCorrect = false
    
    /// 正解の答え
    var correctAnswers: [Answers.AnswersType: Bool] {
        return quizBrain.getCorrectAnswers()
    }

    /// 問題文
    var questionStr: String {
        return quizBrain.getQuestion()
    }
    
    /// 問題の解説文
    var questionExplanation: String {
        return quizBrain.getExplanation() ?? ""
    }
    
    ///問題が択一か複数かどうか
    var multipleCorrect: Bool {
        return quizBrain.getMultipleCorrectAnswers()
    }
    
    /// 次の問題が最後の問題に達しているか
    var isLastQuestion: Bool {
        return quizBrain.checkLastQuestion()
    }
    
    /// 現在の進捗度
    var progressValue: Float {
        return quizBrain.getProgress()        
    }
        
    /// ずんだもんの表示する画像名
    var imageName = ""
        
    /// 答えの情報セット
    private func setAnswers() {
        answers = quizBrain.getAnswers()
    }

    /// 問題が正解しているかどうかチェックする
    func problemCorrectAnswers() {
        self.isCorrect = quizBrain.isCorrectAnswers() ?? false
        
        self.answerZundamon(correct: self.isCorrect)
        self.playSoundAnswerZundamon(correct: self.isCorrect)
    }
    
    /// チェックをつけたりする制御を行う
    /// - Parameter selectType: チェックをつけるAnswersType
    func updateAnswersChecked(selectType: Answers.AnswersType) {
                
        var selected = false
        
        if multipleCorrect {
            // 複数
            selected = quizBrain.multiplaSelectedTypeUpdate(selectType: selectType)
            answers[selectType.rawValue].checked.toggle()

        } else {
            // 択一
            let (previousType, singleSelected) = quizBrain.singleSelectedTypeUpdate(selectType: selectType)
            selected = singleSelected
            if let safePreviousType = previousType {
                answers[safePreviousType.rawValue].checked.toggle()
            }
            answers[selectType.rawValue].checked.toggle()
        }
        
        self.tapPlaySound(selected: selected)
    }
    
    /// タップ時の音声を流す
    /// - Parameter selected: 選択したのか、非選択なのか
    func tapPlaySound(selected: Bool) {
        if selected {
            // SEを流す
            PlayerBrain.players[.AnswerSelect]?.playSound()
        } else {
            // SEを流す
            PlayerBrain.players[.NotSelect]?.playSound()
        }
    }
    
    /// 確定ボタンの制御
    func confirmBtnSetUpControl() {
        if !multipleCorrect {
            if quizBrain.singleSelectedType != nil {
                // 選択されている状態
                self.confirmBtnIsEnabled = true
            } else {
                // 選択されていない状態
                self.confirmBtnIsEnabled = false
            }
        }
    }
    
    /// 次の問題に移動する処理
    func nextQuestion() {
        // 次の問題に移る前に初期化
        quizBrain.initialization()
        
        // 次の問題に移る
        quizBrain.nextQuestion()
        
        self.setAnswers()
        self.confirmBtnSetUpControl()
        self.randomZundamonToWorry()
    }
    
    /// realmに保存する
    var saveRealmInfo: HistoryInfoModel {
        return quizBrain.realmSave()
    }
    
    
    /// 悩むずんだもんをランダムで表示する
    func randomZundamonToWorry() {
        imageName = ZundamonManager.shared.randomZundamonToWorry().rawValue
    }
        
    ///  問題が正解かどうかでずんだもんの画像を変える
    /// - Parameter correct: 正解かどうか
    func answerZundamon(correct: Bool) {
        imageName = ZundamonManager.shared.answerZundamon(correct: correct).rawValue
    }
        
    /// 問題が正解かどうかで音声を流す
    /// - Parameter correct: 正解かどうか
    func playSoundAnswerZundamon(correct: Bool) {
        ZundamonManager.shared.playSoundAnswerZundamon(correct: correct)
    }
}

