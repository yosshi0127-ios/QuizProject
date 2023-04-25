//
//  ProblemChallengeViewController.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/24.
//

import UIKit

class ProblemChallengeViewController: VerticallyScreenViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    // 正解表示View
    @IBOutlet weak var answerStackView: UIStackView!
    @IBOutlet weak var correctDisplayLabel: UILabel!
    @IBOutlet weak var explanationScrollView: UIScrollView!
    @IBOutlet weak var ecplanationLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
        
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var resultBtn: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var quizBrain = QuizBrain()
    var zundamonManager = ZundamonManager()
        
    // MARK: -- Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpTableView()
        self.zundamonManager.setUIImageView(imageView: self.imageView)
        
        self.updateUI()
        
        // BGMを流す
        PlayerBrain.players[.DanceWithPowder]?.playSound(reset: true)
    }
    
    // MARK: -- Created Method
    
    func setUpTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: Con.ProblemChallengeVC.cellNibName, bundle: nil), forCellReuseIdentifier: Con.ProblemChallengeVC.cellIdentifier)
    }
    
    /// 問題挑戦表示する為の更新
    func updateUI() {
        
        // クイズの取得
        questionLabel.text = self.quizBrain.getQuestion()

        // ずんだもん表示ランダムで変える
        self.zundamonManager.randomZundamonToWorry()
        
        // コメントラベル表示
        self.commentLabel.text = self.quizBrain.getMultipleCorrectAnswers() == true ? "複数選択してほしいのだ" : "一つ選択してほしいのだ"

        // 正解表示View非表示
        self.answerStackView.isHidden = true
        self.correctDisplayLabel.isHidden = true
        self.explanationScrollView.isHidden = true

        // 確定ボタン制御(複数選択の場合、常に活性化させる)
        if quizBrain.getMultipleCorrectAnswers() {
            self.confirmBtn.isEnabled = true
            self.confirmBtn.backgroundColor = .cyanOpa80
        } else {
            self.confirmBtn.isEnabled = false
            self.confirmBtn.backgroundColor = .systemGray3
        }
        
        // tableView選択可にする
        self.tableView.allowsSelection = true
        
        // 確定するボタン表示
        self.confirmBtn.isHidden = false
        // 次へボタン非表示
        self.nextBtn.isHidden = true
        
        // プログレスバー更新
        self.progressView.setProgress(self.quizBrain.getProgress(), animated: true)
    }
        
    /// 確定するボタン押下時の為の更新
    func confirmBtnPressedUpdateUI() {
        
        guard let correct = self.quizBrain.isCorrectAnswers() else {
            // 択一問題の場合で、答えを選択していないのに確定するボタンを押下した時の制御用
            return            
        }
        
        // 正解表示Viewを表示
        self.answerStackView.isHidden = false
        self.correctDisplayLabel.isHidden = false
        // 正解か不正解の表示
        self.correctDisplayLabel.text = correct == true ? "正解!!" : "不正解!!"
        // 問題が正解かどうかでずんだもんの画像を変え、音声を流す
        self.zundamonManager.answerZundamon(correct: correct)
        
        // 解説文表示
        if let explanation = self.quizBrain.getExplanation() {
            self.explanationScrollView.isHidden = false
            self.ecplanationLabel.text = explanation
        }
        
        // 確定するボタン非表示
        self.confirmBtn.isHidden = true
                
        // 次へボタンか結果表示へボタンを表示
        if self.quizBrain.quiz.count > (self.quizBrain.guestionNumber + 1) {
            self.nextBtn.isHidden = false
        } else {
            self.resultBtn.isHidden = false
        }
        
        // tableView選択不可にする
        self.tableView.allowsSelection = false
        
        // tableView更新
        self.tableView.reloadData()
    }
    
    /// 結果表示画面へ遷移する、保存したModelを渡す
    func moveToTheNextScreen(_ model: HistoryInfoModel) {
        // 結果画面へ遷移する
        let storyboard = UIStoryboard(name: Con.ResultVC.name, bundle: nil)
        let resultVC = storyboard.instantiateViewController(withIdentifier: Con.ResultVC.identifier) as! ResultViewController
        resultVC.modalPresentationStyle = .fullScreen
        resultVC.modalTransitionStyle = .partialCurl
        
        // 結果表示画面のhistoryModelにセット
        resultVC.model = model

        self.present(resultVC, animated: true)
    }
    
    // MARK: -- @IBAction
    
    @IBAction func confirmBtnPressed(_ sender: UIButton) {
        
        self.confirmBtnPressedUpdateUI()
        
        // SEを流す
        PlayerBrain.players[.ButtonTap1]?.playSound()
    }
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        self.quizBrain.initialization()
        self.quizBrain.nextQuestion()
        
        self.updateUI()
        
        self.tableView.reloadData()
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        
        // SEを流す
        PlayerBrain.players[.ButtonTap1]?.playSound()
    }
    
    @IBAction func resultBtnPressed(_ sender: UIButton) {
        // SE(ずんだもん)を流す
        PlayerBrain.players[.終了なのだ]?.playSound()
        
        // 1.5秒後に結果表示画面へ遷移するように制御
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let model = self.quizBrain.realmSave()
            
            self.moveToTheNextScreen(model)
        }

        // 一度押したら押させないように制御
        self.resultBtn.isEnabled = false
    }
}

// MARK: -- UITableViewDataSource

extension ProblemChallengeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let answers = self.quizBrain.getAnswers()
        
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Con.ProblemChallengeVC.cellIdentifier, for: indexPath) as! ProblemChallengeTableViewCell
        
        cell.tag = indexPath.row
        
        let answersType = Answers.AnswersType(rawValue: indexPath.row)!
        cell.label.text = self.quizBrain.getAnswerStr(type: answersType)!
                
        // 択一選択の表示を反映する
        if let selectedAnswerRaw = quizBrain.singleSelectedType?.rawValue {
            if cell.tag == selectedAnswerRaw {
                cell.cellSelected = true
            }
        }
        
        // 複数選択の表示を反映する
        for selectedAnswers in quizBrain.multipleSelectedType {
            if cell.tag == selectedAnswers.rawValue {
                cell.cellSelected = true
            }
        }
        
        if quizBrain.answered {
            self.quizBrain.cellAnsweredUpdateUI(cell)
        }
        
        return cell
    }
}

// MARK: -- UITableViewDelegate

extension ProblemChallengeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! ProblemChallengeTableViewCell
        print("\(cell.tag)番目がタップされた")
        
        // 択一の場合は、前のcellがあるかどうか判断し、あったら非選択状態にする
        if let answerType = self.quizBrain.singleSelectedType {
            let beforeCell = self.tableView.cellForRow(at: IndexPath(row: answerType.rawValue, section: 0)) as! ProblemChallengeTableViewCell
            beforeCell.cellSelected = false
        }
        
        // cellの管理はQuizBrainで行う、cell更新
        self.quizBrain.cellPressedUpdataUI(cell)

        // 確定ボタンの制御(択一選択の場合のみ行う)
        if !self.quizBrain.getMultipleCorrectAnswers() {
            if self.quizBrain.singleCellSelected() {
                // 選択している場合,
                self.confirmBtn.isEnabled = true
                self.confirmBtn.backgroundColor = .cyanOpa80
            } else {
                // 何も選択していない場合
                self.confirmBtn.isEnabled = false
                self.confirmBtn.backgroundColor = .systemGray3
            }
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
