//
//  ObjectDetectionView.swift
//  MLSwift
//
//  Created by Mustafa Bekirov on 21.02.2025.
//

import Vision
import SwiftUI

struct ObjectDetectionView: View {
    @State private var image: UIImage? = nil
    @State private var imageName: String?
    @State private var detections: [VNRecognizedObjectObservation] = []
    @State private var showImagePicker = false
    @State private var isLoading = false
    
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
                }.frame(height: 400)
            } else {
                Text("Select an image to detect traffic lights")
                    .font(.title)
                    .foregroundColor(.gray)
                    .frame(height: 400)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .onTapGesture {
                        withAnimation {
                            isLoading = true
                            showImagePicker = true
                        }
                    }
            }
            
            HStack {
                Button("Choose Image") {
                    isLoading = true
                    showImagePicker = true
                    if image != nil {
                        self.image = nil
                        self.imageName = nil
                        self.detections = []
                        isLoading = false
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Detect Traffic Lights") {
                    if let object = image {
                        yoloModel.detectObjects(in: object) { results in
                            self.detections = results
                        }
                    }
                }
                .padding()
                .background(image == nil ? Color.gray : Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(image == nil)
            }
            .padding()
        }
        .sheet(isPresented: $showImagePicker) {
            isLoading.toggle()
        } content: {
            ImagePicker(selectedImage: self.$image, imageName: self.$imageName).ignoresSafeArea()
        }
    }
}
