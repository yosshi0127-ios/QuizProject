//
//  GenreViewModel.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

@MainActor
class GenreViewModel: ObservableObject {
    private(set) var quizData = [QuizData]()
    private(set) var genreType: GenreBrain.GenreType = .All
    
    @Published var PKHUDShowFlg = false
    @Published var showingAlert = false
    @Published var isModalActive = false    
    
    func getQuizData(genreType: GenreBrain.GenreType) async {
        // ジャンルタイプ保持
        self.genreType = genreType
        
        await loadQuizData(genreType.rawValue)
    }
    
    private func loadQuizData(_ category: String) async {
        PKHUDShowFlg.toggle()
        
        do {
            let repos = try await ServiceManager().loadQuizData(category)
            
            quizData = repos
            
            PKHUDShowFlg.toggle()
            isModalActive.toggle()

        } catch {
            PKHUDShowFlg.toggle()
            showingAlert.toggle()
        }
    }
}
