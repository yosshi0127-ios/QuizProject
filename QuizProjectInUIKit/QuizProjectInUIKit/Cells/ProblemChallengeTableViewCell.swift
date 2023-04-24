//
//  ProblemChallengeTableViewCell.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import UIKit

class ProblemChallengeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainBackground: UIView!
    
    @IBOutlet weak var imageMark: UIImageView!
    
    @IBOutlet weak var shadowView: ShadowView!
    
    @IBOutlet weak var label: UILabel!
    
    var cellSelected: Bool = false {
        didSet {
            self.shadowView.backgroundColor = cellSelected ? .pinkOpa80 : .orangeOpa80
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpLayer()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellSelected = false
        self.imageMark.isHidden = true
        self.imageMark.image = nil
    }
    
    // MARK: -- Created Method
    
    func setUpLayer() {
        self.mainBackground.layer.cornerRadius = 8
        self.mainBackground.layer.masksToBounds = true
        self.backgroundColor = .clear
        self.shadowView.backgroundColor = .orangeOpa80
        
        self.imageMark.isHidden = true
    }
    
    func correctUpdateUI(correct: Bool) {
        self.imageMark.isHidden = false
        
        if correct {
            self.imageMark.image = .markMaru
        } else {
            self.imageMark.image = .markBatsu
        }
    }
}
