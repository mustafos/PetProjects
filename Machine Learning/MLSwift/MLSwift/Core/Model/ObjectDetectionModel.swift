//
//  ObjectDetectionModel.swift
//  MLSwift
//
//  Created by Mustafa Bekirov on 21.01.2025.
//

import CoreML
import Vision
import UIKit

class YOLOv3Model {
    private let model = try! YOLOv3(configuration: MLModelConfiguration())

    func detectObjects(in image: UIImage, completion: @escaping ([VNRecognizedObjectObservation]) -> Void) {
        guard let buffer = ImageProcessor.pixelBuffer(from: image) else { return }

        // Create a VNCoreMLModel from the YOLOv3 model
        let modelRequest = try! VNCoreMLModel(for: model.model)
        
        // Create the Vision request for detecting objects
        let request = VNCoreMLRequest(model: modelRequest) { request, error in
            DispatchQueue.main.async {
                if let results = request.results as? [VNRecognizedObjectObservation] {
                    completion(results)
                }
            }
        }

        // Create a VNImageRequestHandler to handle the image buffer
        let handler = VNImageRequestHandler(cvPixelBuffer: buffer)
        DispatchQueue.global(qos: .userInteractive).async {
            try? handler.perform([request])
        }
    }
}
