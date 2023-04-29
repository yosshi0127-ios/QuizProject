//
//  ResultDetailView.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import SwiftUI

struct ResultDetailView: View {
    
    var viewModel: ResultDetailViewModel
    
    @Environment(\.dismiss) var dismiss
    
    init(problem: ProblemModel) {
        self.viewModel = ResultDetailViewModel(problemModel: problem)
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6)
                .ignoresSafeArea()
            
            Image(viewModel.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                        
            VStack {
                Spacer()
                
                Text(viewModel.dentificationIscorrect ? "正解!!" : "不正解")
                    .font(Font.nikomoziFont(size: 60))
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.8))
                    .padding(.horizontal, 10)
                    .cornerRadius(20)
                    .padding(.bottom, 10)
                
                // 正解の解説文
                ScrollView {
                    Text(viewModel.explanation)
                        .foregroundColor(.black)
                        .background(Color.cyan.opacity(0.8))
                        .padding(.horizontal, 10)
                        .cornerRadius(20)
                }
                .frame(height: 50)
                .hidden(viewModel.explanation.isEmpty ? true : false)
                
                Text(viewModel.identificationQuestion)
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.8))
                    .padding(.horizontal, 10)
                    .cornerRadius(20)
                
                List(viewModel.answers.indices, id: \.self) { index in
                    
                    ResultDetailViewCell(index: index, problemViewModel: viewModel)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
                .iOS16ScrollContentBackground(.hidden)
                .frame(height: UIScreen.main.bounds.height / 3.5)
                                
                Button(action: {
                    dismiss()
                }) {
                    Text("閉じる")
                        .font(Font.nikomoziFont(size: 35))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(Color.cyan.opacity(0.8))
                        .cornerRadius(25)
                        .padding(.horizontal, 32)
                }
            }
        }
        .onAppear {
            viewModel.playSound()
        }
    }
}

struct ResultDetailViewCell: View {
    
    var index: Int
    var problemViewModel: ProblemViewModel
    
    var body: some View {
        
        ZStack {
            Text(problemViewModel.answers[index])
                .frame(maxWidth: .infinity, minHeight: 40)
                .background(problemViewModel.userAnswer[index] ? Color.pink.opacity(0.8) : Color.orange.opacity(0.8))
                .cornerRadius(10)
            
            Image(problemViewModel.correctAnswer[index] ? "mark_maru" : "mark_batsu")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .opacity(0.8)
        }
    }
}

struct ResultDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ResultDetailView(problem: .mock1)
    }
}
