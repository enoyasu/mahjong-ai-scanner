//
//  CameraView.swift
//  mahjong-ai-scanner
//
//  Created by 榎本康寿 on 2025/02/06.
//

import SwiftUI
import AVFoundation

// カメラのアクセス権限状態を確認するための関数
func checkCameraAuthorization() -> Bool {
    let status = AVCaptureDevice.authorizationStatus(for: .video)
    switch status {
    case .authorized:
        return true
    case .notDetermined:
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                print("カメラへのアクセスが許可されました")
            } else {
                print("カメラへのアクセスが拒否されました")
            }
        }
        return false
    default:
        return false
    }
}

// カメラプレビュー
struct CameraPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let captureSession = AVCaptureSession()
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        // カメラデバイスの取得
        guard let device = AVCaptureDevice.default(for: .video) else {
            print("カメラデバイスが見つかりません")
            return UIView() // クラッシュを防ぐために空のビューを返す
        }
        // カメラ入力の設定
        do {
            let input = try AVCaptureDeviceInput(device: device)
            captureSession.addInput(input)
        } catch {
            print("カメラ入力の設定に失敗しました")
            return UIView()
        }
        
        // プレビューレイヤーの設定
        previewLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let view = UIView()
        view.layer.addSublayer(previewLayer)
        
        // キャプチャセッションの開始
        captureSession.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

// カメラビュー
struct CameraView: View {
    let navigateToRoot: () -> Void
    
    @State private var isCameraAuthorized = false
    
    var body: some View {
        Group {
            if isCameraAuthorized {
                CameraPreview()
            } else {
                Text("カメラへのアクセスが許可されていません")
            }
        }
        .onAppear {
            isCameraAuthorized = checkCameraAuthorization()
        }
    }
}

