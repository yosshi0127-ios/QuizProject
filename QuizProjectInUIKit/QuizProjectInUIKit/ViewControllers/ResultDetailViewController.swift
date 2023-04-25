//
//  ResultDetailViewController.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/25.
//

import UIKit

class ResultDetailViewController: VerticallyScreenViewController {
        
    
    @IBOutlet weak var imageView: UIImageView!
    
    // 正解表示View
    @IBOutlet weak var correctDisplayLabel: UILabel!
    @IBOutlet weak var explanationScrollView: UIScrollView!
    @IBOutlet weak var explanationLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var problem = ProblemModel()
    var zundamonManager = ZundamonManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpTableView()
        self.zundamonManager.setUIImageView(imageView: self.imageView)
        self.updateUI()
    }
    
    // MARK: -- Created Method

    func setUpTableView() {
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        // tableView選択不可にする
        self.tableView.allowsSelection = false
        // cellは問題挑戦画面使い回す
        self.tableView.register(UINib(nibName: Con.ProblemChallengeVC.cellNibName, bundle: nil), forCellReuseIdentifier: Con.ProblemChallengeVC.cellIdentifier)
    }
    
    ///  レイアウトセット
    func updateUI() {
        // クイズの取得
        self.questionLabel.text = self.problem.getIdentificationQuestion()

        let correct = self.problem.getIdentificationIscorrect()
        // 正解か不正解の表示
        self.correctDisplayLabel.text = correct == true ? "正解!!" : "不正解!!"
        // ずんだもんの画像を正解か不正解で変える
        self.zundamonManager.answerZundamon(correct: correct)
        
        // 解説文表示
        if let explanation = self.problem.getExplanation() {
            self.explanationScrollView.isHidden = false
            self.explanationLabel.text = explanation
        }
    }
        
    // MARK: -- @IBAction
    
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        // SEを流す
        PlayerBrain.players[.NotSelect]?.playSound()
        
        self.dismiss(animated: true)
    }
    
}

// MARK: -- UITableViewDataSource

extension ResultDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.problem.answers?.getAnswersArr().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Con.ProblemChallengeVC.cellIdentifier, for: indexPath) as! ProblemChallengeTableViewCell
        
        // 選択肢の文字列を取得
        let answersArr = self.problem.answers?.getAnswersArr()
        cell.label.text = answersArr?[indexPath.row]
        
        // 回答状態を取得
        let userAnswer = self.problem.userAnswer?.getConnectAnswerArr()
        cell.cellSelected = userAnswer?[indexPath.row] == true ? true : false
        
        // 正答を取得
        let correctAnswer = self.problem.correctAnswer?.getConnectAnswerArr()
        cell.correctUpdateUI(correct: (correctAnswer?[indexPath.row])!)
        
        return cell
    }
}

