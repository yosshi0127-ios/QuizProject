//
//  GenreBrain.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import Foundation

struct GenreBrain {
    
    // 選択したジャンル(デフォルトAll)
    var selectedGenreType: GenreType = .All
    
    enum GenreType: String, CaseIterable {
        case All = "All"
        case Code = "Code"
        case Docker = "Docker"
        case Linux = "Linux"
        case SQL = "SQL"
    }    
}
