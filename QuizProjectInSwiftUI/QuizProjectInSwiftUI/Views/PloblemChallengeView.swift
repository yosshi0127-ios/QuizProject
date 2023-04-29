//
//  PloblemChallengeView.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import SwiftUI

struct PloblemChallengeView: View {
    @StateObject var viewModel: ProblemChallengeViewModel
    
    var body: some View {
        
        ZStack {
            Color(UIColor.systemGray6)
                .ignoresSafeArea()

            Image(viewModel.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack {
                Text(viewModel.multipleCorrect ? "複数選択してほしいのだ" : "一つ選択してほしいのだ")
                    .font(Font.nikomoziFont(size: 30))
                    .padding(.top, 20)
                
                Spacer()
                
                Text(viewModel.isCorrect ? "正解!!" : "不正解")
                    .font(Font.nikomoziFont(size: 60))
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.8))
                    .padding(.horizontal, 10)
                    .cornerRadius(20)
                    .padding(.bottom, 10)
                    .visible(viewModel.answerd)
                                
                // 正解の解説文
                ScrollView {
                    Text(viewModel.questionExplanation)
                        .foregroundColor(.black)
                        .background(Color.cyan.opacity(0.8))
                        .padding(.horizontal, 10)
                        .cornerRadius(20)
                }
                .frame(height: 50)
                .hidden(viewModel.explanationHidden)
                
                Text(viewModel.questionStr)
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.8))
                    .padding(.horizontal, 10)
                    .cornerRadius(20)
                
                List(viewModel.answers, id: \.type) { answer in
                    
                    PloblemListCellView(viewModel: viewModel, problemAnswer: answer) { type in
                        // 回答済みだったら反映させない
                        if !viewModel.answerd {
                            viewModel.updateAnswersChecked(selectType: type)
                            viewModel.confirmBtnSetUpControl()
                        }
                    }
                }
                .iOS16ScrollContentBackground(.hidden)
                .frame(height: UIScreen.main.bounds.height / 3.5)
                
                BottomButonView(viewModel: viewModel)
                    .padding(.bottom, 5)                
                
                ProgressView(value: viewModel.progressValue)
                    .padding(.horizontal, 20)
                    .tint(.green)
            }
        }
        .onAppear {
            // BGMを流す
            PlayerBrain.players[.DanceWithPowder]?.playSound(reset: true)
        }
        .onDisappear {
            // 結果表示画面からのトップへ戻る際、onAppearが呼ばれDanceWithPowderが再生されてしまうので、onDisappearでトップ画面の曲を流す
            PlayerBrain.players[.Syuwasyuwa]?.playSound()
        }
        .fullScreenCover(isPresented: $viewModel.quizFinish) {
            ResultView(model: viewModel.saveRealmInfo, beforeIsActive: .constant(false))
        }
    }
}

// ListのCell
struct PloblemListCellView: View {
    
    @ObservedObject var viewModel: ProblemChallengeViewModel
    var problemAnswer: PloblemAnswer
    private var handler: (Answers.AnswersType) -> Void

    init(viewModel: ProblemChallengeViewModel, problemAnswer: PloblemAnswer, handler: @escaping (Answers.AnswersType) -> Void) {
        self.viewModel = viewModel
        self.problemAnswer = problemAnswer
        self.handler = handler
    }
    
    var body: some View {
        
        ZStack {
            Text(problemAnswer.answer)
                .frame(maxWidth: .infinity, minHeight: 40)
                .background(problemAnswer.checked ? Color.pink.opacity(0.8) : Color.orange.opacity(0.8))
                .cornerRadius(10)
                .onTapGesture {
                    handler(problemAnswer.type)
                }
            
            Image(viewModel.correctAnswers[problemAnswer.type]! ? "mark_maru" : "mark_batsu")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .opacity(0.8)
                .visible(viewModel.confirmBtnVisible)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)

    }
}


///  確定するボタン、次の問題へボタン、結果表示へボタン
struct BottomButonView: View {
    
    @ObservedObject var viewModel: ProblemChallengeViewModel
    
    var body: some View {
        // ZStackで重ねる
        ZStack {
            Button(action: {
                // SEを流す
                PlayerBrain.players[.ButtonTap1]?.playSound()
                
                viewModel.problemCorrectAnswers()
                
                // 確定するボタン非表示
                viewModel.confirmBtnVisible.toggle()
                                
                if !viewModel.isLastQuestion {
                    // 次へボタン表示
                    viewModel.nextBtnHidden.toggle()
                } else {
                    // 結果表示へボタン表示
                    viewModel.resultBtnHidden.toggle()
                }
                
                // 正解の解説文の表示、非表示制御 (正解の解説文が空文字ではない場合表示)
                if !viewModel.questionExplanation.isEmpty {
                    viewModel.explanationHidden.toggle()
                }
                                
                // 回答済み制御、trueに変更
                viewModel.answerd.toggle()
            }, label: {
                Text("確定する")
                    .modifier(PloblemBottomButtonModifier(backgroundColor: viewModel.confirmBtnIsEnabled ? Color.cyan.opacity(0.8) : Color.gray.opacity(0.8), hidden: viewModel.confirmBtnVisible))
            })
            .disabled(!viewModel.confirmBtnIsEnabled)
            
            Button(action: {
                // SEを流す
                PlayerBrain.players[.ButtonTap1]?.playSound()
                
                // 次へボタン非表示
                viewModel.nextBtnHidden.toggle()
                
                // 回答済み制御、falseに変更
                viewModel.answerd.toggle()
                // 確定するボタン表示
                viewModel.confirmBtnVisible.toggle()
                
                // 正解の解説文の非表示
                viewModel.explanationHidden = true

                // 次の問題へ変更する
                viewModel.nextQuestion()
            }, label: {
                Text("次の問題へ")
                    .modifier(PloblemBottomButtonModifier(backgroundColor: Color.green.opacity(0.8), hidden: viewModel.nextBtnHidden))
            })
            // 表示させている時にしか押させない
            .disabled(viewModel.nextBtnHidden)
            
            Button(action: {
                // SE(ずんだもん)を流す
                PlayerBrain.players[.終了なのだ]?.playSound()
                
                // 1.5秒後に結果表示画面へ遷移するように制御
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    // クイズ終了
                    viewModel.quizFinish.toggle()
                }
                
                // 一度押したら押させないように制御
                viewModel.resultBtnIsEnabled.toggle()
            }, label: {
                Text("結果表示へ")
                    .modifier(PloblemBottomButtonModifier(backgroundColor: Color.pink.opacity(0.8), hidden: viewModel.resultBtnHidden))
            })
            // 一度押したら押させないように制御
            .disabled(viewModel.resultBtnIsEnabled)
        }
    }
}

struct PloblemChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        PloblemChallengeView(viewModel: ProblemChallengeViewModel(genreType: .All, quiz: [.mock1, .mock2]))
    }
}
