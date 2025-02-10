//
//  ResultView.swift
//  mahjong-ai-scanner
//
//  Created by 榎本康寿 on 2025/02/09.
//

import SwiftUI

struct ResultView: View {
    let quizItems: [QuizItem]         // クイズデータ
    let selectedAnswers: [[String]]  // ユーザーが選択した回答
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("結果")
                    .font(.largeTitle)
                    .bold()
                
                let correctCount = calculateCorrectCount()
                let totalQuestions = quizItems.count
                
                Text("正答数：\(correctCount)/\(totalQuestions)")
                    .font(.title2)
                
                Text("正答率：\(String(format: "%.2f", (Double(correctCount) / Double(totalQuestions)) * 100))%")
                    .font(.title2)
                
                Divider()
                
                ForEach(0..<quizItems.count, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Q\(index + 1).")
                            .font(.headline)
                        
                        Image(quizItems[index].imageName) // 問題画像を表示
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                        
                        Text("選択した回答：")
                            .font(.subheadline)
                        
                        // ユーザーが選択した回答を画像で表示
                        HStack {
                            ForEach(selectedAnswers[index], id: \.self) { answer in
                                Image(answer)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        
                        Text("正解：")
                            .font(.subheadline)
                        
                        // 正解を画像で表示
                        HStack {
                            ForEach(quizItems[index].correctAnswers, id: \.self) { correctAnswer in
                                Image(correctAnswer)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(
                                                selectedAnswers[index].contains(correctAnswer) ?
                                                Color.green : Color.red,
                                                lineWidth: 2
                                            )
                                    )
                            }
                        }
                        
                        Divider() // 区切り線
                    }
                }
            }
            .padding()
        }
    }
    
    func calculateCorrectCount() -> Int {
        var count = 0
        for index in 0..<quizItems.count {
            if Set(selectedAnswers[index]) == Set(quizItems[index].correctAnswers) {
                count += 1
            }
        }
        return count
    }
}
