//
//  PlayerBrain.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import Foundation

class PlayerBrain {
    static let players: [SoundName: Player] = [
        // BGM
        .Syuwasyuwa: Player(model: SoundModel(name: .Syuwasyuwa, type: .BGM), numberOfLoops: true),
        .ShallWeMeet:  Player(model: SoundModel(name: .ShallWeMeet, type: .BGM), numberOfLoops: true),
        .DanceWithPowder:  Player(model: SoundModel(name: .DanceWithPowder, type: .BGM), numberOfLoops: true),
        .Unfortunate:  Player(model: SoundModel(name: .Unfortunate, type: .BGM), numberOfLoops: true),
        .春のキッチン:  Player(model: SoundModel(name: .春のキッチン, type: .BGM), numberOfLoops: true),
        .SunriseBGM:  Player(model: SoundModel(name: .SunriseBGM, type: .BGM), numberOfLoops: true),
                
        // SE
        .ButtonTap1:  Player(model: SoundModel(name: .ButtonTap1, type: .SE), numberOfLoops: false),
        .AnswerSelect:  Player(model: SoundModel(name: .AnswerSelect, type: .SE), numberOfLoops: false),
        .NotSelect:  Player(model: SoundModel(name: .NotSelect, type: .SE), numberOfLoops: false),

        // ずんだもん
        .ジャンルを選択するのだ:  Player(model: SoundModel(name: .ジャンルを選択するのだ, type: .SE), numberOfLoops: false),
        .正解なのだ:  Player(model: SoundModel(name: .正解なのだ, type: .SE), numberOfLoops: false),
        .不正解なのだ:  Player(model: SoundModel(name: .不正解なのだ, type: .SE), numberOfLoops: false),
        .終了なのだ:  Player(model: SoundModel(name: .終了なのだ, type: .SE), numberOfLoops: false),
        .すごいのだ天才なのだ:  Player(model: SoundModel(name: .すごいのだ天才なのだ, type: .SE), numberOfLoops: false),
        .まずまずなのだ次は満点目指すのだ:  Player(model: SoundModel(name: .まずまずなのだ次は満点目指すのだ, type: .SE), numberOfLoops: false),
        .もう少し頑張るのだファイトなのだ:  Player(model: SoundModel(name: .もう少し頑張るのだファイトなのだ, type: .SE), numberOfLoops: false),
        .次は頑張るのだ応援してるのだ:  Player(model: SoundModel(name: .次は頑張るのだ応援してるのだ, type: .SE), numberOfLoops: false),
        .えええ勉強するのだ:  Player(model: SoundModel(name: .えええ勉強するのだ, type: .SE), numberOfLoops: false)
    ]
    
}
