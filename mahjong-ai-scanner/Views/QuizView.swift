//
//  QuizView.swift
//  mahjong-ai-scanner
//
//  Created by 榎本康寿 on 2025/02/07.
//

import SwiftUI

struct QuizItem {
    let question = "待ち牌を全て選択してください" // 問題
    let choices: [String]         // 選択肢
    let correctAnswers: [String]  // 正解
    let imageName: String         // 画像ファイル名
}

// カスタムボタン
struct CustomButtonStyle: ButtonStyle {
    // 条件に応じて色を変えるためのプロパティ
    var backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: 40) // タップ領域を拡大
            .background(configuration.isPressed ? Color.gray : backgroundColor) // 背景色を条件で変更
            .foregroundColor(.white) // 文字色
            .cornerRadius(8) // 角丸
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // 押下時のアニメーション効果
    }
}

struct QuizView: View {
    let quizItems: [QuizItem] // クイズデータ
    let navigateToRoot: () -> Void // クロージャ型のプロパティを追加
    
    @State private var currentQuizIndex = 0 // 現在のクイズインデックス
    @State private var selectedAnswers: [[String]] = [] // 現在選択された回答
    @State private var isAnswerSubmitted = false // 回答が提出されたかどうか
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // 動的に現在の問題番号を含む質問文を表示
                Text("問題\(currentQuizIndex + 1)/10")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.title3)
                    .padding(5)
                Text("待ち牌を全て選択してください")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.title2)
                    .bold()
                // デバッグ用コードはbody外で実行
                let _ = Swift.debugPrint("デバッグ用出力:", selectedAnswers, currentQuizIndex)
                if currentQuizIndex < selectedAnswers.count {
                    let _ = Swift.debugPrint("デバッグ用出力:", selectedAnswers, currentQuizIndex)
                } else {
                    let _ = "無効なインデックスです"
                }
                Image(quizItems[currentQuizIndex].imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .background(Color.mint.opacity(0.2))
                    .cornerRadius(10)
                    .padding(5)
            
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible()), count: 12)
                ) {
                    if currentQuizIndex < quizItems.count {
                        ForEach(quizItems[currentQuizIndex].choices, id: \.self) { option in
                            Button(action: { toggleSelection(for: option) }) {
                                Image(option)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .background(selectedAnswers.indices.contains(currentQuizIndex) &&
                                                selectedAnswers[currentQuizIndex].contains(option) ?
                                                Color.blue.opacity(0.5) : Color.clear)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(selectedAnswers.indices.contains(currentQuizIndex) &&
                                                    selectedAnswers[currentQuizIndex].contains(option) ?
                                                    Color.blue : Color.gray, lineWidth: 2)
                                    )
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding(5)
                
                //                Button(action: submitAnswer) {
                //                    Text("回答する")
                //                        .frame(maxWidth: .infinity)
                //                        .padding()
                //                        .background(Color.blue)
                //                        .foregroundColor(.white)
                //                        .cornerRadius(10)
                //                }
                
                HStack {
                    // 「前へ」ボタン
                    if currentQuizIndex > 0 {
                        Button(action: {
                            previousQuiz()
                        }) {
                            Text("前へ")
                        }
                        .buttonStyle(CustomButtonStyle(backgroundColor: Color.orange)) // 背景色をオレンジに設定
                    }
                    
                    Spacer()
                    
                    // 「次へ」ボタン
                    if currentQuizIndex < quizItems.count - 1 {
                        Button(action: {
                            nextQuiz()
                        }) {
                            Text("次へ")
                        }
                        .buttonStyle(CustomButtonStyle(backgroundColor: Color.green)) // 背景色を緑に設定
                    } else {
                        // 「結果を見る」ボタン
                        NavigationLink(destination:
                                        ResultView(quizItems: quizItems, selectedAnswers: selectedAnswers)) {
                            Text("結果を見る")
                        }
                                        .buttonStyle(CustomButtonStyle(backgroundColor: Color.purple)) // 背景色を紫に設定
                    }
                }
            }
        }
        // onAppearでデバッグ情報を出力
        .onAppear {
            print("現在の選択状態：", selectedAnswers)
            print("現在のクイズインデックス：", currentQuizIndex)
            
            if currentQuizIndex < selectedAnswers.count {
                print("現在選択された回答：", selectedAnswers[currentQuizIndex])
            }
        }
        
        .onAppear {
            // 各問題ごとの選択状態を初期化
            selectedAnswers = Array(repeating: [], count: quizItems.count) // 二次元配列として初期化
        }
    }
    
    // 選択肢の選択・解除処理
    func toggleSelection(for option: String) {
        guard currentQuizIndex < selectedAnswers.count else {
            print("無効なインデックス: \(currentQuizIndex)")
            return
        }
        
        if selectedAnswers[currentQuizIndex].contains(option) {
            selectedAnswers[currentQuizIndex].removeAll { $0 == option }
        } else {
            selectedAnswers[currentQuizIndex].append(option)
        }
    }
    
    // 回答を提出する処理
    func submitAnswer() {
        guard currentQuizIndex < selectedAnswers.count else {
            print("無効なインデックス: \(currentQuizIndex)")
            return
        }
        
        isAnswerSubmitted = true
        let correctAnswers = quizItems[currentQuizIndex].correctAnswers
        
        if Set(selectedAnswers[currentQuizIndex]) == Set(correctAnswers) {
            print("正解！")
        } else {
            print("不正解！")
        }
    }
    
    // 次のクイズに進む処理
    func nextQuiz() {
        guard currentQuizIndex < quizItems.count - 1 else {
            print("最後のクイズです")
            return
        }
        submitAnswer()
        // 次のクイズに進む
        currentQuizIndex += 1
        // 状態リセット
        resetState()
    }
    
    // 前のクイズに戻る処理
    func previousQuiz() {
        if currentQuizIndex > 0 {
            currentQuizIndex -= 1
            resetState()
        }
    }
    
    // 状態をリセットする処理（次や前に移動した際）
    func resetState() {
        // 現在のクイズインデックスの選択状態のみリセット
        if currentQuizIndex < selectedAnswers.count {
            selectedAnswers[currentQuizIndex] = []
        }
        isAnswerSubmitted = false
    }
    
    func showResults() {
        print("結果画面に遷移します")
    }
    
    // デバッグ用関数を追加
    func debugPrint() {
        print(selectedAnswers)
        print(currentQuizIndex)
        if currentQuizIndex < selectedAnswers.count {
            print(selectedAnswers[currentQuizIndex])
        }
    }
}

// プレビュー用データと構造体
struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        // ダミーデータを作成
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
                choices: ["pinzu_2","pinzu_3","pinzu_4","pinzu_5","pinzu_6","manzu_6","manzu_7","manzu_8","manzu_9","haku"],
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
        
        // QuizViewのプレビューを表示
        QuizView(quizItems: quizItems, navigateToRoot: {})
            .previewInterfaceOrientation(.landscapeRight) // 横画面プレビュー
    }
}
