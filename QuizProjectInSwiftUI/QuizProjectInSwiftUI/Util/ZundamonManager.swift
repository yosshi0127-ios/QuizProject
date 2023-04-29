//
//  ZundamonManager.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

enum ZundamonImages: String {
    case standard = "zundamon_standard"
    case jitome = "zundamon_jitome"
    case joy = "zundamon_joy"
    case angry = "zundamon_angry"
    case angry2 = "zundamon_angry2"
    case confusion = "zundamon_confusion"
    case sad = "zundamon_sad"
    case toWorry = "zundamon_toWorry"
    case toWorry2 = "zundamon_toWorry2"
    case yami = "zundamon_yami"
}

class ZundamonManager {
    
    static let shared = ZundamonManager()
    
    private let zundamonToWorry: [ZundamonImages] = [.toWorry, .toWorry2, .jitome]
        
    /// 悩むずんだもんをランダムで表示する
    func randomZundamonToWorry() -> ZundamonImages {
        return zundamonToWorry.randomElement()!
    }
    
    ///  問題が正解かどうかでずんだもんの画像を変える
    /// - Parameter correct: true(正解)、false(不正解)
    func answerZundamon(correct: Bool) -> ZundamonImages {
        return correct == true ? .joy : .angry
    }
    
    /// 問題が正解かどうかで音声を流す
    func playSoundAnswerZundamon(correct: Bool) {
        correct == true ? PlayerBrain.players[.正解なのだ]?.playSound() : PlayerBrain.players[.不正解なのだ]?.playSound()
    }
    
    ///　正答率によって、画像を返す
    /// - Parameter accuracyRate: 正答率
    /// - Returns: 画像
    func accuracyRateZundamon(accuracyRate: Int) -> ZundamonImages {
        
        switch accuracyRate {
        case 90...100:
            print("90-100点")
            return .joy
        case 60..<89:
            print("60ー89点")
            return .jitome
        case 30..<59:
            print("30ー59点")
            return .toWorry
        case 20..<29:
            print("20ー29点")
            return .sad
        case 0..<19:
            print("0ー19点")
            return .confusion
        default:
            print("正答率がおかしいです。 正答率: \(accuracyRate)")
            
            return .standard
        }
    }
    

}
