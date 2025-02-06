//
//  CustomModalView.swift
//  mahjong-ai-scanner
//
//  Created by 榎本康寿 on 2025/02/06.
//

import SwiftUI

struct CustomModalView: View {
    @Binding var isPresented: Bool // モーダル表示状態をバインド
    let onConfirm: () -> Void // 「はい」をクリックしたときの処理
    
    var body: some View {
        VStack(spacing: 20) {
            Text("タイトルに戻りますか？")
                .font(.headline)
            
            HStack(spacing: 20) {
                Button("キャンセル") {
                    isPresented = false // モーダルを閉じる（いいえ）
                }
                .foregroundColor(.white)
                .padding()
                .frame(width: 100, height: 40)
                .background(Color.red)
                .cornerRadius(8)
                
                Button("OK") {
                    isPresented = false // モーダルを閉じる（はい）
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        onConfirm() // Main画面に戻る処理を実行
                    }
                }
                .foregroundColor(.white)
                .padding()
                .frame(width: 100, height: 40)
                .background(Color.blue)
                .cornerRadius(8)
            }
        }
        .padding()
        .frame(maxWidth: 300, maxHeight: 200) // モーダルサイズを調整
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 10)
    }
}

