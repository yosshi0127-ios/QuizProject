//
//  ResultViewController.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/25.
//

import UIKit

class ResultViewController: UIViewController {
        
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var accuracyRateLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
                
    @IBOutlet weak var topScreenBtn: UIButton!
    
    var model = HistoryInfoModel()
    var zundamonManager = ZundamonManager()
    
    // MARK: -- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpTableView()
        self.zundamonManager.setUIImageView(imageView: self.imageView)
        
        self.updateUI()
    }
    
    // MARK: -- Created Method
    
    func setUpTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: Con.ResultVC.cellNibName, bundle: nil), forCellReuseIdentifier: Con.ResultVC.cellIdentifier)
    }
    
    func updateUI() {
        // 選択ジャンルと問題数取得して反映
        let genreName = self.model.getGenre()
        let problemNumber = self.model.getProblemNumber()
        self.topLabel.text = "選択ジャンル: \(genreName)   全\(problemNumber)問"
        
        // 正答数と正答率を取得して反映
        let answersNumber = self.model.getProblemzAnswersNumber()
        let accuracyRate = self.model.getAccuracyRate()
        self.accuracyRateLabel.text = "正答数: \(answersNumber)  正答率: \(accuracyRate)%"
        self.zundamonManager.accuracyRateZundamon(accuracyRate: accuracyRate)
                
        // 前の画面が履歴表示画面の場合、トップへ戻るボタンは非表示にする
        if let nc = self.navigationController,
           let _ = nc.viewControllers[nc.viewControllers.count - 2] as? ResultListViewController {
            self.topScreenBtn.isHidden = true
        }
    }
    
    // MARK: -- @IBAction
    
    @IBAction func topScreenBtnPressed(_ sender: Any) {
        // SEを流す
        PlayerBrain.players[.NotSelect]?.playSound()
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: false)
    }
}

// MARK: -- UITableViewDataSource

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.getProblemNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Con.ResultVC.cellIdentifier, for: indexPath) as! ResultTableViewCell
        cell.tag = indexPath.row
        
        cell.configure(problem: self.model.problems[indexPath.row])
        
        return cell
    }
}

// MARK: -- UITableViewDelegate

extension ResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! ResultTableViewCell
        print("\(cell.tag)番目がタップされた")
                
        let resultDetailVC = UIStoryboard(name: Con.ResultDetailVC.name, bundle: nil).instantiateViewController(withIdentifier: Con.ResultDetailVC.identifier) as! ResultDetailViewController
        
        resultDetailVC.problem = self.model.problems[indexPath.row]
        self.present(resultDetailVC, animated: true)
        
        // SEを流す
        PlayerBrain.players[.ButtonTap1]?.playSound()
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
 
