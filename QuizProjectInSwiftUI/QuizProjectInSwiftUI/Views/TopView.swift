//
//  ContentView.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/28.
//

import SwiftUI

struct TopView: View {
        
    @ObservedObject var animationViewModel = AnimationImageViewModel(imageNames: [ZundamonImages.standard.rawValue, ZundamonImages.jitome.rawValue, ZundamonImages.joy.rawValue])
    
    @ObservedObject var viewModel = TopViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(animationViewModel.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(animationViewModel.flag ? 1 : 0)
                
                VStack {
                    Text("IT quiz!!")
                        .font(Font.nikomoziFont(size: 45))
                        .foregroundColor(.green)
                    
                    Spacer()
                                        
                    HomeButtonBottomView()
                }
            }
            .onAppear {                
                animationViewModel.startTimer()
                
                // BGMを流す
                PlayerBrain.players[.Syuwasyuwa]?.playSound()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("メッセージ"),
                      message: Text("このアプリではBGM、および効果音が鳴ります。よろしいですか？"),
                      primaryButton: .cancel(Text("キャンセル")),    // キャンセル用
                      secondaryButton: .default(Text("OK"), action: {
                    print("OKが押されました")
                    viewModel.setUserDefault()
                    
                    // BGMを流す
                    PlayerBrain.players[.Syuwasyuwa]?.playSound()
                })
                )
            }

        }
    }
}

struct HomeButtonBottomView: View {
    
    var body: some View {
        
        VStack(spacing: 40) {
            
            NavigationLink(destination: LazyView(GenreSelectView())) {
                Text("クイズに挑戦")
                    .font(Font.nikomoziFont(size: 45))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .background(Color.pink.opacity(0.8))
                    .cornerRadius(25)
                    .padding(.horizontal, 32)
            }.simultaneousGesture(TapGesture().onEnded {
                // SEを流す
                PlayerBrain.players[.ButtonTap1]?.playSound()
            })
            
            NavigationLink(destination: LazyView(ResultListView())) {
                Text("挑戦履歴")
                    .font(Font.nikomoziFont(size: 45))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .background(Color.cyan.opacity(0.8))
                    .cornerRadius(25)
                    .padding(.horizontal, 32)
            }.simultaneousGesture(TapGesture().onEnded {
                // SEを流す
                PlayerBrain.players[.ButtonTap1]?.playSound()
            })
        }
        .padding(.bottom, 50)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
