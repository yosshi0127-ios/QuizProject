//
//  GenreSelectScreenViewController.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import UIKit
import PKHUD

class GenreSelectViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let genreType = GenreBrain.GenreType.allCases
    
    // MARK: -- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Con.GenreSelectVC.title

        self.setUpTableView()
        
        // SE(ずんだもん)を流す
        PlayerBrain.players[.ジャンルを選択するのだ]?.playSound()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                            
        // 結果表示画面からdismissで戻った場合に、この画面までしか戻らないため前の画面があったらpopToRootViewControllerで戻る
        if let _ = self.presentedViewController {
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
    deinit {
        print("GenreSelectViewController - deinit")
    }
    
    // MARK: -- Created Method
    
    func setUpTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: Con.GenreSelectVC.cellNibName, bundle: nil), forCellReuseIdentifier: Con.GenreSelectVC.cellIdentifier)
    }
        
    func getQuizSuccessNextScreen(category: String) {

        // HUD表示
        HUD.show(.progress)
        
        ServiceManager().getQuiz(category: category) { [weak self] (result) in

            DispatchQueue.main.async {
                switch result {

                case .success(let quizData):                    
                    self?.moveToTheNextScreen(genreType: GenreBrain.GenreType(rawValue: category)!, quizData)
                case .failure(let error):
                    print("ServiceManager().getQuiz failuer: \(error)")
                    self?.showSingleBtnAlert(title: "クイズの問題取得に失敗したのだ", message: "")
                }
                
                // HUD非表示
                HUD.hide()
            }
        }
    }
        
    func moveToTheNextScreen(genreType: GenreBrain.GenreType, _ quizData: [QuizData]) {
//        let storyboard = UIStoryboard(name: Con.ProblemChallengeVC.name, bundle: nil)
//        let problemChallengeVC = storyboard.instantiateViewController(withIdentifier: Con.ProblemChallengeVC.identifier) as! ProblemChallengeViewController
//        problemChallengeVC.modalPresentationStyle = .fullScreen
//        problemChallengeVC.modalTransitionStyle = .crossDissolve
        
        // 問題挑戦画面のクイズにセット
//        problemChallengeVC.quizBrain.setQuiz(genreType: genreType, quiz: quizData)
        
//        self.present(problemChallengeVC, animated: true)
    }
}

// MARK: -- UITableViewDataSource

extension GenreSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Con.GenreSelectVC.cellIdentifier, for: indexPath) as! GenreSelectTableViewCell
        let genre = self.genreType[indexPath.row]

        cell.genreLabel.text = genre.rawValue
        
        return cell
    }
}

// MARK: -- UITableViewDelegate

extension GenreSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! GenreSelectTableViewCell
        getQuizSuccessNextScreen(category: cell.genreLabel.text ?? "All")
        
        // SEを流す
        PlayerBrain.players[.ButtonTap1]?.playSound()
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
