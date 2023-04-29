//
//  ResultListView.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import SwiftUI

struct ResultListView: View {
    @StateObject var viewModel = ResultListViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    @State var isActive = false
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
            
        ZStack {
            Image(ZundamonImages.jitome.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack {
                NavigationLink(destination: Group {
                    if let selectedModel = viewModel.selectedModel {
                        LazyView(ResultView(model: selectedModel, beforeIsActive: $isActive, topScreenBtnIsHidden: true))
                    }}
                               , isActive: $isActive) {
                    EmptyView()
                }
                
                ZStack {
                    Text("履歴情報がないのだ")
                        .foregroundColor(Color.white)
                        .font(Font.nikomoziFont(size: 40))
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .background(Color.cyan.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .hidden(!viewModel.models.isEmpty)
                 
                    Text("詳細を確認するには\nタップするのだ")
                        .foregroundColor(Color.white)
                        .font(Font.nikomoziFont(size: 25))
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .background(Color.cyan.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .hidden(viewModel.models.isEmpty)
                }
                .padding(.top, 20)
                
                Spacer()

                List(viewModel.models, id: \.id) { model in
                    ResultListViewCell(viewModel: model)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .onTapGesture {
                            viewModel.selectedModel = model
                            isActive = true
                        }
                }
                .iOS16ScrollContentBackground(.hidden)
                .frame(height: UIScreen.main.bounds.height / 2.5)
                .visible(!viewModel.models.isEmpty)

                Button(action: {
                    // SEを流す
                    PlayerBrain.players[.NotSelect]?.playSound()
                    
                    dismiss()
                }) {
                    Text("戻る")
                        .font(Font.nikomoziFont(size: 35))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(Color.green.opacity(0.8))
                        .cornerRadius(25)
                        .padding(.horizontal, 32)
                }
            }
        }.onAppear {            
            // realmから取得
            viewModel.setModels()
            
            // BGMを流す
            PlayerBrain.players[.ShallWeMeet]?.playSound()
        }
        
        .navigationTitle("履歴一覧")
        .navigationBarTitleDisplayMode(.inline)
    }

}

struct ResultListViewCell: View {
    var viewModel: HistoryInfoViewModel
    
    init(viewModel: HistoryInfoModel) {
        self.viewModel = HistoryInfoViewModel(historyInfoModel: viewModel)
    }
    
    var body: some View {
        
        VStack(spacing: 10) {
            HStack {
                Text("\(viewModel.dateStr)")
                Text("挑戦ジャンル: \(viewModel.genre)")
            }
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .padding([.top, .leading, .trailing], 10)
            
            Text("全 \(viewModel.ploblemNumber)問")
            
            HStack {
                Text("正答数: \(viewModel.ploblemzAnswersNumber)")
                Text("正答率: \(viewModel.accracyRate)%")
            }
            .padding([.bottom], 10)
            
        }
        .frame(maxWidth: .infinity, minHeight: 40)
        .background(Color.orange.opacity(0.8))
        .cornerRadius(10)
    }
}


struct ResultListView_Previews: PreviewProvider {
    static var previews: some View {
        ResultListView()
    }
}
