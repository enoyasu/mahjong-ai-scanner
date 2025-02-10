//
//  ContentView.swift
//  mahjong-ai-scanner
//
//  Created by 榎本康寿 on 2025/02/03.
//

import SwiftUI

struct ContentView: View {
    @State private var isDebugMode = true
    @State private var navigateToHome = false // 遷移フラグ
    
    init() {
        if isDebugMode {
            print("Debugging mode is enabled")
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
//                if isDebugMode {
//                    Text("Debug Mode")
//                        .foregroundColor(.red)
//                } else {
//                    Text("Normal Mode")
//                        .foregroundColor(.blue)
//                }
//                
//                Button(action: toggleMode) {
//                    Text("Toggle Mode")
//                }
            }
            ZStack {
                // 背景色を白に固定
                Color.white
                    .ignoresSafeArea() // セーフエリアを無視して全画面に適用

                // テキスト
                Text("Tap To Start")
                    .font(.largeTitle)
                    .foregroundColor(.blue) // テキストの色を青に固定
            }
            .preferredColorScheme(.light) // カラースキーマをライトモードに固定
            
            .onTapGesture {
                navigateToHome = true // タップ時に遷移フラグを更新
            }
            .navigationDestination(isPresented: $navigateToHome) {
                HomeView(navigateToRoot: { navigateToHome = false }) // 遷移先の画面
            }
            .navigationTitle("") // タイトルを空に設定
            // navigationTitleを設定しないことで、戻るボタンを「<」のみにする
            .navigationBarBackButtonHidden(false) // デフォルトの戻るボタンを有効化
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("") // 空のタイトルで戻るボタンを「<」だけにする
                }
            }
        }
    }
    func toggleMode() {
        isDebugMode.toggle()
        print("Toggled mode to \(isDebugMode ? "Debug" : "Normal")")
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight) // 横画面プレビュー
    }
}

#Preview {
    ContentView()
}


