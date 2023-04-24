//
//  ZundamonManager.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/24.
//

import UIKit

struct ZundamonManager {
        
    var imageView: UIImageView?
    
    mutating func setUIImageView(imageView: UIImageView) {
        self.imageView = imageView
    }
    
    let zundamonToWorry: [UIImage] = [.zundamonToWorry, .zundamonToWorry2, .zundamonJitome]
    /// 悩むずんだもんをランダムで表示する
    func randomZundamonToWorry() {
        self.imageView?.image = zundamonToWorry.randomElement()
    }
    
    ///  問題が正解かどうかでずんだもんの画像を変え、音声を流す
    /// - Parameter correct: true(正解)、false(不正解)
    func answerZundamon(correct: Bool) {
        self.imageView?.image = correct == true ? .zundamonJoy : .zundamonAngry
        
        correct == true ? PlayerBrain.players[.正解なのだ]?.playSound() : PlayerBrain.players[.不正解なのだ]?.playSound()
    }
    
    /// 　正答率によってずんだもんの画像を返して、 曲も流しちゃう
    /// - Parameter accuracyRate: 正答率
    func accuracyRateZundamon(accuracyRate: Int) {
        
        switch accuracyRate {
        case 90...100:
            self.imageView?.image = .zundamonJoy
            
            PlayerBrain.players[.SunriseBGM]?.playSound(reset: true)
            
            PlayerBrain.players[.すごいのだ天才なのだ]?.playSound()
            print("90-100点")
        case 60..<89:
            self.imageView?.image = .zundamonJitome
            
            PlayerBrain.players[.春のキッチン]?.playSound(reset: true)
            
            PlayerBrain.players[.まずまずなのだ次は満点目指すのだ]?.playSound()
            print("60ー89点")
        case 30..<59:
            self.imageView?.image = .zundamonToWorry
            
            PlayerBrain.players[.春のキッチン]?.playSound(reset: true)
            
            PlayerBrain.players[.もう少し頑張るのだファイトなのだ]?.playSound()
            print("30ー59点")
        case 20..<29:
            self.imageView?.image = .zundamonSad2
            
            PlayerBrain.players[.Unfortunate]?.playSound(reset: true)
            
            PlayerBrain.players[.次は頑張るのだ応援してるのだ]?.playSound()
            print("20ー29点")
        case 0..<19:
            self.imageView?.image = .zundamonConfusion

            PlayerBrain.players[.Unfortunate]?.playSound(reset: true)
            
            PlayerBrain.players[.えええ勉強するのだ]?.playSound()
            print("0ー19点")
        default:
            print("正答率がおかしいです。 正答率: \(accuracyRate)")
        }
    }
}

