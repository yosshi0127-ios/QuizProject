//
//  Constants.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import Foundation

struct Con {
    
    struct TopVC {
        static let name = "TopScreeen"
    }
    
    struct GenreSelectVC {
        static let title = "ジャンル選択"
        static let name = "GenreSelectScreen"
        static let identifier = "GenreSelectScreen"
        
        static let cellNibName = "GenreSelectTableViewCell"
        static let cellIdentifier = "GenreSelectTableViewCell"
    }
    
    struct ProblemChallengeVC {
        static let name = "ProblemChallengeScreen"
        static let identifier = "ProblemChallengeScreen"
        
        static let cellNibName = "ProblemChallengeTableViewCell"
        static let cellIdentifier = "ProblemChallengeTableViewCell"
    }
    
    struct ResultVC {
        static let name = "ResultScreen"
        static let identifier = "ResultScreen"
        
        static let cellNibName = "ResultTableViewCell"
        static let cellIdentifier = "ResultTableViewCell"
    }
    
    struct ResultDetailVC {
        static let name = "ResultDetailScreen"
        static let identifier = "ResultDetailScreen"
    }
    
    struct ResultListVC {
        static let title = "履歴一覧"
        static let name = "ResultListScreen"
        static let identifier = "ResultListScreen"
        
        static let cellNibName = "ResultListTableViewCell"
        static let cellIdentifier = "ResultListTableViewCell"
        
    }
    
}
