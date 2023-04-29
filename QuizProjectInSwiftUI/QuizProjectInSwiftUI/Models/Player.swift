//
//  Player.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import AVFoundation

struct SoundModel {
    let name: SoundName
    let type: SoundType
}

enum SoundName: String {
    
    // BGM
    case Syuwasyuwa = "syuwasyuwaBGM"
    case ShallWeMeet = "Shall_we_meet?BGM"
    case DanceWithPowder = "Dance_With_PowderBGM"
    case Unfortunate = "残念BGM"
    case 春のキッチン = "春のキッチンBGM"
    case SunriseBGM = "SunriseBGM"
        
    // SE
    case ButtonTap1 = "ButtonTap1"
    case AnswerSelect = "AnswerSelect"
    case NotSelect = "NotSelect"
    
    // SE(ずんだもん)
    case ジャンルを選択するのだ = "ジャンルを選択するのだ"
    case 正解なのだ = "正解なのだ"
    case 不正解なのだ = "不正解なのだ"
    case 終了なのだ = "終了なのだ"
    case すごいのだ天才なのだ = "すごいのだ、天才なのだ"
    case まずまずなのだ次は満点目指すのだ = "まずまずなのだ、次は満点目指すのだ"
    case もう少し頑張るのだファイトなのだ = "もう少し頑張るのだ、ファイトなのだ"
    case 次は頑張るのだ応援してるのだ = "次は頑張るのだ、応援してるのだ"
    case えええ勉強するのだ = "えええ、、勉強するのだ"

}

enum SoundType: String {
    case BGM = "BGM"
    case SE = "SE"
}

class Player {
    private var audioPlayer: AVAudioPlayer!
    private var soundModel: SoundModel!

    init(model: SoundModel, numberOfLoops: Bool = false) {
        guard let path = Bundle.main.path(forResource: model.name.rawValue, ofType: "mp3") else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer.delegate = self as? AVAudioPlayerDelegate
            audioPlayer.numberOfLoops = numberOfLoops == true ? -1 : 0
            self.soundModel = model
        } catch {
            print("\(error)")
        }
    }
    
    func playSound(reset: Bool = false) {
        // 許可している時のみ流す
        if !UserDefaults.standard.bool(forkey: .soundFlg) { return }
        
        if soundModel.type == .BGM {
            // 再生しているの全部止める
            for player in PlayerBrain.players.values {
                if player.soundModel.type == .BGM {
                    player.stopSound()
                    
                }
            }
        }

        // resetがtrueまたは、SEの場合は初めから流す
        if reset || self.soundModel.type == .SE {
            audioPlayer.currentTime = 0
        }
        
        if self.soundModel.type == .BGM {
            audioPlayer.volume = 0.5
        }
        
        audioPlayer.play()
    }
    
    func stopSound() {
        audioPlayer.stop()
    }
}
