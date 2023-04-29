//
//  GenreSelectView.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import SwiftUI

struct GenreSelectView: View {
    
    @ObservedObject private var genreViewModel = GenreViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        ZStack {
            Color(UIColor.systemGray6)
                .ignoresSafeArea()
            
            VStack {
                
                Image(ZundamonImages.joy.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text("ジャンルを選択するのだ")
                    .font(Font.nikomoziFont(size: 35))
                
                List {
                    ForEach(GenreBrain.GenreType.allCases) { genreType in
                        
                        Text("\(genreType.rawValue)")
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(Color.orange)
                            .cornerRadius(10)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        
                            .onTapGesture {
                                // SEを流す
                                PlayerBrain.players[.ButtonTap1]?.playSound()
                                
                                Task {
                                    print("\(genreType)")
                                    
                                    await genreViewModel.getQuizData(genreType: genreType)
                                }
                            }
                    }
                    .iOS16ScrollContentBackground(.hidden)

                }
                .fullScreenCover(isPresented: $genreViewModel.isModalActive, onDismiss: {                    
                    dismiss()
                }) {
                    PloblemChallengeView(viewModel: ProblemChallengeViewModel(genreType: genreViewModel.genreType, quiz: genreViewModel.quizData))
                }
                .PKHUD(isPresented: $genreViewModel.PKHUDShowFlg, HUDContent: .progress)
                .alert(isPresented: $genreViewModel.showingAlert) {
                    Alert(title: Text("クイズの問題取得に失敗したのだ"))
                }
            }
        }.onAppear {
            // SE(ずんだもん)を流す
            PlayerBrain.players[.ジャンルを選択するのだ]?.playSound()
        }
        
        .navigationTitle("ジャンル選択")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GenreSelectView_Previews: PreviewProvider {
    static var previews: some View {
        GenreSelectView()
    }
}
