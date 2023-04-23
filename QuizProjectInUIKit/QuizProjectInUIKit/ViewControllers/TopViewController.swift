//
//  TopViewController.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import UIKit

class TopViewController : UIViewController {
        
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quizChallengeBtn: UIButton!
    @IBOutlet weak var challengeHistoryBtn: UIButton!
      
    var animateImageModel = AnimateImageModel(images: [.zundamonStandard, .zundamonToWorry, .zundamonJitome, .zundamonJoy])
    
    // MARK: -- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.animateImageModel.animateImageView(imageView: self.imageView)

        if !UserDefaults.standard.bool(forkey: .soundFlg) {
            self.showCommonLabelAlert(title: "このアプリではBGM、および効果音が鳴ります。よろしいですか？", message: "", okHandler: {
                UserDefaults.standard.set(true, forKey: .soundFlg)

                // BGMを流す
                PlayerBrain.players[.Syuwasyuwa]?.playSound()
            },cancelHandler: {
                print("Cacelしました")
            })
        }

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // BGMを流す
        PlayerBrain.players[.Syuwasyuwa]?.playSound()
    }

    // MARK: -- IBAction
    
    @IBAction func quizChallengePressed(_ sender: UIButton) {
        
//        let storyboard = UIStoryboard(name: Con.GenreSelectVC.name, bundle: nil)
//        let genreSelectViewController = storyboard.instantiateViewController(withIdentifier: Con.GenreSelectVC.identifier) as! GenreSelectViewController

        // SEを流す
        PlayerBrain.players[.ButtonTap1]?.playSound()

//        navigationController?.pushViewController(genreSelectViewController, animated: true)
    }
    
    @IBAction func challengeHistoryPressed(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: Con.ResultListVC.name, bundle: nil)
//        let resultListVC = storyboard.instantiateViewController(withIdentifier: Con.ResultListVC.identifier) as! ResultListViewController

        // SEを流す
        PlayerBrain.players[.ButtonTap1]?.playSound()

//        navigationController?.pushViewController(resultListVC, animated: true)
    }
    
    
}
