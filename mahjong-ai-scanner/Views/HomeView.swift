//
//  HomeView.swift
//  mahjong-ai-scanner
//
//  Created by 榎本康寿 on 2025/02/06.
//

import SwiftUI

struct HomeView: View {
    let navigateToRoot: () -> Void // Main画面に戻るためのクロージャ
    @State private var showModal = false // モーダル表示フラグ
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 背景画像
                Image("mahloung-image")
                    .resizable()
                    .scaledToFill() // 画面全体を埋める
                    .ignoresSafeArea() // セーフエリア外も表示
                VStack(spacing: 20) {
                    NavigationLink(destination: CameraView(navigateToRoot: navigateToRoot)) {
                        Text("カメラ起動")
                            .font(.title2)
                            .frame(width: 300, height: 50)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    // トレーニング画面への遷移
                    NavigationLink(destination: TrainingView(navigateToRoot: navigateToRoot)) {
                        Text("トレーニング")
                            .font(.title2)
                            .frame(width: 300, height: 50)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle("") // タイトルを空に設定
            // navigationTitleを設定しないことで、戻るボタンを「<」のみにする
            .navigationBarBackButtonHidden(false) // デフォルトの戻るボタンを有効化
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("") // 空のタイトルで戻るボタンを「<」だけにする
                }
                // 左上にカスタムボタンを配置
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showModal = true // モーダルを表示
                    }) {
                        Image(systemName: "house.fill") // 家のアイコン
                            .font(.title)
                    }
                }
            }
            // モーダルの表示
            .sheet(isPresented: $showModal) {
                // カスタムモーダルビュー
                CustomModalView(isPresented: $showModal, onConfirm: navigateToRoot)
            }
        }
    }
}
