//
//  CameraView.swift
//  mahjong-ai-scanner
//
//  Created by 榎本康寿 on 2025/02/06.
//

import SwiftUI

struct CameraView: View {
    // Main画面に戻るためのクロージャ
    let navigateToRoot: () -> Void
    // モーダル表示フラグ
    @State private var showModal = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Camera Screen")
                .font(.largeTitle)
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
