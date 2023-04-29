//
//  GenreBrain.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

struct GenreBrain {
    
    // 選択したジャンル(デフォルトAll)
    var selectedGenreType: GenreType = .All    
    
    enum GenreType: String, CaseIterable, Identifiable {
        var id: String { rawValue }
        
        case All = "All"
        case Code = "Code"
        case Docker = "Docker"
        case Linux = "Linux"
        case SQL = "SQL"
    }
}

