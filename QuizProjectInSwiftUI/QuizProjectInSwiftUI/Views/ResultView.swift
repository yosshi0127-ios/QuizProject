//
//  ResultView.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import SwiftUI

struct ResultView: View {
    
    var viewModel: ResultViewModel
    @State var isActive = false
    
    @Binding var beforeIsActive: Bool
    
    var topScreenBtnIsHidden: Bool
    
    init(model: HistoryInfoModel, beforeIsActive: Binding<Bool>, topScreenBtnIsHidden: Bool = false) {
        self.viewModel = ResultViewModel(historyInfoModel: model)
        self._beforeIsActive = beforeIsActive
        self.topScreenBtnIsHidden = topScreenBtnIsHidden
    }

    var body: some View {
        
        ZStack {
            Color(UIColor.systemGray6)
                .ignoresSafeArea()
                        
            Image(viewModel.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                        
            VStack {
                HStack {
                    Text("選択ジャンル: \(viewModel.genre)")
                    Text("\(viewModel.ploblemNumber)問")
                }
                .font(Font.title)
                
                Spacer()
                
                HStack {
                    Text("正答数:\(viewModel.ploblemzAnswersNumber)")
                    Text("正答率:\(viewModel.accracyRate)%")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.white.opacity(0.8))
                .font(Font.nikomoziFont(size: 30))

                List(viewModel.problmes.indices, id: \.self) { index in

                    ResultListCellView(index: index, problem: viewModel.problmes[index])
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .onTapGesture {
                            isActive.toggle()
                            self.viewModel.selectedProblem = viewModel.problmes[index]
                        }
                }
                .iOS16ScrollContentBackground(.hidden)
                .frame(height: UIScreen.main.bounds.height / 2.5)
                .sheet(isPresented: $isActive) {
                    ResultDetailView(problem: self.viewModel.selectedProblem!)
                }
                
                Button(action: {
                    let scenes = UIApplication.shared.connectedScenes
                    let windowScene = scenes.first as? UIWindowScene

                    windowScene?.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: false, completion: nil)
                }) {
                    Text("トップに戻る")
                        .font(Font.nikomoziFont(size: 35))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(Color.pink.opacity(0.8))
                        .cornerRadius(25)
                        .padding(.horizontal, 32)
                        .hidden(topScreenBtnIsHidden)
                }
            }
        }
        .onAppear {
            // 前画面が履歴画面だったら、前画面に戻った場合再度生成されてしまう為ここで制御
            self.beforeIsActive = false
            
            viewModel.playSound()
        }
    }
}

struct ResultListCellView: View {
    
    var index: Int
    var problemViewModel: ProblemViewModel
    
    init(index: Int, problem: ProblemModel) {
        self.index = index
        self.problemViewModel = ProblemViewModel(problemModel: problem)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(index + 1)")
                    .padding(.leading, 10)
                
                Spacer()
                
                Text(problemViewModel.multipleCorrectAnswers ? "複数問題なのだ" : "択一問題なのだ")
                    .font(Font.title3)
                
                Spacer()
                
                Text(problemViewModel.dentificationIscorrect ? "正解" : "不正解")
                    .font(Font.nikomoziFont(size: 25))
                    .padding(.trailing, 10)
            }
            .padding([.top, .bottom], 10)
            
            Text(problemViewModel.identificationQuestion)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .padding([.leading, .trailing, .bottom], 10)
            
        }
        .frame(maxWidth: .infinity, minHeight: 40)
        .background(problemViewModel.dentificationIscorrect ? Color.cyan.opacity(0.8) : Color.pink.opacity(0.8))
        .cornerRadius(10)
    }
}


struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(model: .mock1, beforeIsActive: .constant(false))
    }
}
