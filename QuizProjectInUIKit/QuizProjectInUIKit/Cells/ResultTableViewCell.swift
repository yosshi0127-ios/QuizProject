//
//  ResultTableViewCell.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/25.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var mainBackground: UIView!
    
    @IBOutlet weak var shadowLayer: ShadowView!
    
    @IBOutlet weak var questionNumberLabel: UILabel!
        
    @IBOutlet weak var problemTypeLabel: UILabel!
        
    @IBOutlet weak var isCorrectLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUpLayer()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: -- Created Method
    
    func setUpLayer() {
        self.mainBackground.layer.cornerRadius = 8
        self.mainBackground.layer.masksToBounds = true
        self.backgroundColor = .clear
    }
    
    /// cellのレイアウトを更新
    /// - Parameter modelBrain: modelBrain
    func configure(problem: ProblemModel) {

        // 問題のNumberセット
        self.questionNumberLabel.text = String(self.tag + 1)
        
        // 複数問題か択一問題かをセット
        self.problemTypeLabel.text = problem.getIdentificationMultipleCorrectAnswers() == true ? "複数問題なのだ" : "択一問題なのだ"
        
        // 正解か不正解か取得
        let isCorrect = problem.getIdentificationIscorrect()

        // 正解か不正解かで色を返す
        self.shadowLayer.backgroundColor = isCorrect == true ? .cyanOpa80 : .pinkOpa80
        
        // 正解か不正解で文字列をセット
        self.isCorrectLabel.text = isCorrect == true ? "正解" : "不正解"
        
        // 問題文を取得しセット
        self.questionLabel.text = problem.getIdentificationQuestion()
    }
}
