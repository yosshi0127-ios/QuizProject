//
//  ResultViewModel.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

class HistoryInfoViewModel {
    private var historyInfoModel: HistoryInfoModel
    
    init(historyInfoModel: HistoryInfoModel) {
        self.historyInfoModel = historyInfoModel
    }
    
    /// 挑戦日時
    var dateStr: String {
        return historyInfoModel.getDateStr()
    }
    
    /// 各問題の情報
    var problmes: [ProblemModel] {
        return Array(historyInfoModel.problems)
    }
            
    /// ジャンル
    var genre: String {
        return historyInfoModel.getGenre()
    }
    
    /// 問題数
    var ploblemNumber: Int {
        return historyInfoModel.getProblemNumber()
    }
    
    /// 正答数
    var ploblemzAnswersNumber: Int {
        return historyInfoModel.getProblemzAnswersNumber()
    }
    
    /// 正答率
    var accracyRate: Int {
        return historyInfoModel.getAccuracyRate()
    }
    
    /// 正答率によって音楽、SEを再生する
    func accuracyRatePlaySound() {
                
        switch self.accracyRate {
        case 90...100:
            PlayerBrain.players[.SunriseBGM]?.playSound(reset: true)
            
            PlayerBrain.players[.すごいのだ天才なのだ]?.playSound()
        case 60..<89:
            print("60ー89点")
            PlayerBrain.players[.春のキッチン]?.playSound(reset: true)
            
            PlayerBrain.players[.まずまずなのだ次は満点目指すのだ]?.playSound()
        case 30..<59:
            print("30ー59点")
            PlayerBrain.players[.春のキッチン]?.playSound(reset: true)
            
            PlayerBrain.players[.もう少し頑張るのだファイトなのだ]?.playSound()
        case 20..<29:
            print("20ー29点")
            PlayerBrain.players[.Unfortunate]?.playSound(reset: true)
            
            PlayerBrain.players[.次は頑張るのだ応援してるのだ]?.playSound()
        case 0..<19:
            print("0ー19点")
            PlayerBrain.players[.Unfortunate]?.playSound(reset: true)
            
            PlayerBrain.players[.えええ勉強するのだ]?.playSound()
        default:
            print("正答率がおかしいです。 正答率: \(self.accracyRate)")
        }
    }
    
    
    
}
