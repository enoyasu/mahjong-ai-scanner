//
//  TrainingView.swift
//  mahjong-ai-scanner
//
//  Created by 榎本康寿 on 2025/02/06.
//

import SwiftUI

struct TrainingView: View {
    // QuizView 問題
    let quizItems = [
        QuizItem(
            choices: ["pinzu_1","pinzu_2","pinzu_3","pinzu_4","pinzu_5","pinzu_6","pinzu_7","pinzu_8","pinzu_9","sozu_7","sozu_8","haku"],
            correctAnswers: ["pinzu_2","pinzu_5","pinzu_8"],
            imageName: "handTiles_258p"
        ),
        QuizItem(
            choices: ["manzu_1","manzu_3","manzu_5","pinzu_1","pinzu_3","pinzu_5","sozu_1","sozu_2","sozu_3","sozu_4","sozu_5","ton"],
            correctAnswers: ["sozu_1","sozu_4","ton"],
            imageName: "handTiles_14s-ton"
        ),
        QuizItem(
            choices: ["pinzu_1","pinzu_2","pinzu_3","pinzu_4","pinzu_5","pinzu_6","sozu_3","sozu_5","sozu_7","manzu_5","manzu_7","manzu_9"],
            correctAnswers: ["pinzu_2","pinzu_3","pinzu_4"],
            imageName: "handTiles_234p"
        ),
        QuizItem(
            choices: ["sozu_1","sozu_2","sozu_3","sozu_4","sozu_5","sozu_6","sozu_7","sozu_8","sozu_9","pinzu_4","pinzu_6","pinzu_8"],
            correctAnswers: ["sozu_2","sozu_4","sozu_5","sozu_7","sozu_8"],
            imageName: "handTiles_24578s"
        ),
        QuizItem(
            choices: ["manzu_1","manzu_2","manzu_3","manzu_4","manzu_5","manzu_6","manzu_7","manzu_8","manzu_9","pinzu_7","pinzu_9","sozu_3"],
            correctAnswers: ["manzu_2","manzu_5","manzu_8"],
            imageName: "handTiles_258m-head"
        ),
        QuizItem(
            choices: ["pinzu_2","pinzu_3","pinzu_4","pinzu_6","pinzu_7","manzu_1","manzu_2","manzu_3","sozu_5","sozu_7","sozu_8","sozu_9"],
            correctAnswers: ["pinzu_3","pinzu_4","pinzu_6"],
            imageName: "handTiles_346p"
        ),
        QuizItem(
            choices: ["sozu_1","sozu_2","sozu_3","sozu_4","sozu_5","sozu_6","sozu_7","sozu_8","sozu_9","ton"],
            correctAnswers: ["sozu_3","sozu_5","sozu_6"],
            imageName: "handTiles_356s"
        ),
        QuizItem(
            choices: ["sozu_1","sozu_2","sozu_6","manzu_7","manzu_8","manzu_9","pinzu_3","pinzu_4","pinzu_5","pinzu_6","haku","hatsu"],
            correctAnswers: ["pinzu_3","pinzu_4","pinzu_5","pinzu_6"],
            imageName: "handTiles_3456p"
        ),
        QuizItem(
            choices: ["pinzu_2","pinzu_3","pinzu_4","pinzu_5","pinzu_6","pinzu_7","sozu_5","sozu_6","sozu_7","sozu_8","sozu_9","ton"],
            correctAnswers: ["pinzu_4","pinzu_5","pinzu_7"],
            imageName: "handTiles_457p"
        ),
        QuizItem(
            choices: ["manzu_1","manzu_2","manzu_3","manzu_4","manzu_5","manzu_6","manzu_7","pinzu_1","pinzu_4","sozu_5","sozu_7","sozu_9"],
            correctAnswers: ["manzu_1","manzu_2","manzu_4","manzu_7"],
            imageName: "handTiles_1247m"
        )
    ]
    // Main画面に戻るためのクロージャ
    let navigateToRoot: () -> Void
    // モーダル表示フラグ
    @State private var showModal = false
    
    var body: some View {
        ZStack {
            // 背景画像
            Image("mahjong_background_blur")
                .resizable()
                .scaledToFill() // 画面全体を埋める
                .ignoresSafeArea() // セーフエリア外も表示
            
            VStack(spacing: 20) {
                // クイズボタン
                NavigationLink(destination: QuizView(quizItems: quizItems, navigateToRoot: {})
                ) {
                    Text("クイズ")
                        .font(.title)
                        .frame(width: 300, height: 50)
                        .padding()
                        .background(Color.teal)
                        .foregroundColor((Color(red: 0.0, green: 0.0, blue: 0.5)))
                        .cornerRadius(8)
                }
                // タイムアタックボタン
                NavigationLink(destination: TimeAttackView(navigateToRoot: navigateToRoot)) {
                    Text("タイムアタック")
                        .font(.title)
                        .frame(width: 300, height: 50)
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.red)
                        .cornerRadius(8)
                }
                
                
                // 多面張一覧ボタン
                NavigationLink(destination: WaitsListView(navigateToRoot: navigateToRoot)) {
                    Text("多面張 一覧")
                        .font(.title)
                        .frame(width: 300, height: 50)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                //            // 履歴ボタン
                //            Button("履歴") {
                //                print("履歴ボタンが押されました")
                //                // 必要なアクションをここに記述
                //            }
                //            .font(.title2)
                //            .padding()
                //            .background(Color.green)
                //            .foregroundColor(.white)
                //            .cornerRadius(8)
            }
        }
        
        .navigationTitle("") // タイトルを空に設定
        // navigationTitleを設定しないことで、戻るボタンを「<」のみにする
        .navigationBarBackButtonHidden(false) // デフォルトの戻るボタンを有効化
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("") // 空のタイトルで戻るボタンを「<」だけにする
            }
            // 左上にカスタムボタンを配置（家アイコン）
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    // モーダルを表示
                    showModal = true
                }) {
                    Image(systemName: "house.fill") // 家のアイコン
                        .font(.title)
                }
            }
        }
        // モーダルの表示
        .sheet(isPresented: $showModal) {
            CustomModalView(isPresented: $showModal, onConfirm: navigateToRoot)
        }
    }
}


struct UniformButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            configuration.label
                .frame(width: geometry.size.width * 0.25, height: 50) // 横幅を親ビューいっぱいに広げ、高さ50px
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // 押したときのアニメーション
        }
    }
}



