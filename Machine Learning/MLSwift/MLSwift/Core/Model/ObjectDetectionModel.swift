//
//  ObjectDetectionModel.swift
//  MLSwift
//
//  Created by Mustafa Bekirov on 21.01.2025.
//

import CoreML
import Vision
import SwiftUI

class YOLOv3Model {
    let model = try! YOLOv3(configuration: MLModelConfiguration())

    func detectObjects(in image: UIImage, completion: @escaping ([VNRecognizedObjectObservation]) -> Void) {
        guard let buffer = ImageProcessor.pixelBuffer(from: image) else { return }
        
        let request = VNCoreMLRequest(model: try! VNCoreMLModel(for: model.model)) { request, error in
            DispatchQueue.main.async {
                if let results = request.results as? [VNRecognizedObjectObservation] {
                    completion(results)
                }
            }
        }
        
        let handler = VNImageRequestHandler(cvPixelBuffer: buffer)
        DispatchQueue.global(qos: .userInteractive).async {
            try? handler.perform([request])
        }
    }
}
