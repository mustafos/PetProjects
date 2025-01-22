//
//  ObjectDetectionView.swift
//  MLSwift
//
//  Created by Mustafa Bekirov on 21.02.2025.
//

import Vision
import SwiftUI

struct ObjectDetectionView: View {
    @State private var image: UIImage? = UIImage(named: "sample")
    @State private var detections: [VNRecognizedObjectObservation] = []

    let yoloModel = YOLOv3Model()

    var body: some View {
        VStack {
            if let image = image {
                GeometryReader { geometry in
                    ZStack {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                        
                        ForEach(detections, id: \.uuid) { detection in
                            BoundingBoxView(boundingBox: detection.boundingBox, imageSize: image.size, viewSize: geometry.size)
                        }
                    }
                }
            }
            
            Button("Detect Objects") {
                if let img = image {
                    yoloModel.detectObjects(in: img) { results in
                        self.detections = results
                    }
                }
            }
            .padding()
        }
    }
}
