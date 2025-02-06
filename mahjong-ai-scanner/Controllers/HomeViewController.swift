//
//  HomeViewController.swift
//  mahjong-ai-scanner
//
//  Created by 榎本康寿 on 2025/02/03.
//

import UIKit
import CoreML
import Vision

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let image = UIImage(named: "sample.jpg") else { return }
        performDetection(on: image)
    }

    lazy var detectionRequest: VNCoreMLRequest = {
        do {
            // MLModelConfigurationを使用してYOLOv3を初期化
            let configuration = MLModelConfiguration()
            let yoloModel = try YOLOv3(configuration: configuration).model
            
            // Vision用のVNCoreMLModelを作成
            let model = try VNCoreMLModel(for: yoloModel)
            let request = VNCoreMLRequest(model: model) { request, error in
                self.handleDetectionResults(results: request.results)
            }
            request.imageCropAndScaleOption = .scaleFill
            return request
        } catch {
            fatalError("Failed to load CoreML model: \(error)")
        }
    }()

    func performDetection(on image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([detectionRequest])
        } catch {
            print("Failed to perform detection: \(error)")
        }
    }

    func handleDetectionResults(results: [Any]?) {
        guard let observations = results as? [VNRecognizedObjectObservation] else { return }
        for observation in observations {
            print("Detected object: \(observation.labels.first?.identifier ?? "Unknown")")
            print("Confidence: \(observation.labels.first?.confidence ?? 0)")
            print("BoundingBox: \(observation.boundingBox)")
        }
    }
}

