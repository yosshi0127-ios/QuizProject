//
//  ResultListViewController.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/25.
//

import UIKit

class ResultListViewController: UIViewController {

    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var models = [HistoryInfoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.title = Con.ResultListVC.title

        self.setUpTableView()
        self.getHistoryInfoModelAndSetUP()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        // BGMを流す
        PlayerBrain.players[.ShallWeMeet]?.playSound(reset: true)
    }
    
    // MARK: -- Created Method
    func setUpTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: Con.ResultListVC.cellNibName, bundle: nil), forCellReuseIdentifier: Con.ResultListVC.cellIdentifier)
    }
    
    func getHistoryInfoModelAndSetUP() {
        let models = RepositoryManager().getHistoryInfoModels()
        self.models = models.sorted(by: {$0.date.compare($1.date) == .orderedDescending
        })
        if self.models.count > 0 {
            self.commentLabel.text = "詳細を確認するには\nタップするのだ"
        }
    }
        
    // MARK: -- @IBAction
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        // SEを流す
        PlayerBrain.players[.NotSelect]?.playSound()
        
        self.navigationController?.popViewController(animated: true)
    }    
}

// MARK: -- UITableViewDataSource

extension ResultListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Con.ResultListVC.cellIdentifier, for: indexPath) as! ResultListTableViewCell
        
        cell.configure(self.models[indexPath.row])
                
        return cell
    }
}

// MARK: -- UITableViewDelegate

extension ResultListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 結果画面へ遷移する
        let storyboard = UIStoryboard(name: Con.ResultVC.name, bundle: nil)
        let resultVC = storyboard.instantiateViewController(withIdentifier: Con.ResultVC.identifier) as! ResultViewController
        
        // 結果表示画面のhistoryModelにセット
        resultVC.model = self.models[indexPath.row]

        navigationController?.pushViewController(resultVC, animated: true)
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

