//
//  ResultListTableViewCell.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/25.
//

import UIKit

class ResultListTableViewCell: UITableViewCell {

    @IBOutlet weak var mainBackground: UIView!
        
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var problemNumber: UILabel!
    
    @IBOutlet weak var correctNumber: UILabel!
    @IBOutlet weak var accuracyRateLabel: UILabel!
    
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
    
    func configure(_ model: HistoryInfoModel) {
        // 日付セット(秒数も)
        self.dataLabel.text = model.getDateStr()
        
        // ジャンル取得、表示
        self.genreLabel.text = "挑戦ジャンル: \(model.getGenre())"
        
        // 問題数取得、表示
        self.problemNumber.text = "全 \(model.getProblemNumber())問"        
        
        // 正答数取得、表示
        self.correctNumber.text = "正答数: \(model.getProblemzAnswersNumber())門"
        
        // 正答率取得、表示
        self.accuracyRateLabel.text = "正答率: \(model.getAccuracyRate())%"
    }
}
