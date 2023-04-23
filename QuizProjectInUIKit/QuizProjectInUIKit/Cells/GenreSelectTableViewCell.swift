//
//  GenreSelectTableViewCell.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import UIKit

class GenreSelectTableViewCell: UITableViewCell {

    @IBOutlet weak var mainBackground: UIView!
    
    @IBOutlet weak var genreLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpLayer()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpLayer() {
        self.mainBackground.layer.cornerRadius = 8
        self.mainBackground.layer.masksToBounds = true
        self.backgroundColor = .systemGray6
    }
}
