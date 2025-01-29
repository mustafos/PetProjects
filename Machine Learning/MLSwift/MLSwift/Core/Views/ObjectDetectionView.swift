//
//  ObjectDetectionView.swift
//  MLSwift
//
//  Created by Mustafa Bekirov on 21.02.2025.
//

import Vision
import SwiftUI

struct ObjectDetectionView: View {
    @State private var image: UIImage?
    @State private var imageName: String?
    @State private var detections: [VNRecognizedObjectObservation] = []
    @State private var showImagePicker = false
    @State private var showCamera = false
    @State private var isLoading = false
    
    let yoloModel = YOLOv3Model()
    
    var body: some View {
        VStack {
            if showCamera {
                GeometryReader { geometry in
                    ZStack {
                        // Camera view occupies the whole screen
                        CameraView(image: $image, detections: $detections)
                            .ignoresSafeArea()
                        
                        // Display bounding boxes on top of the camera view
                        ForEach(detections, id: \.uuid) { detection in
                            if let image = image {
                                BoundingBoxView(boundingBox: detection.boundingBox, imageSize: image.size, viewSize: geometry.size)
                            }
                        }
                    }
                }
            } else {
                if let image = image {
                    GeometryReader { geometry in
                        ZStack {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                            
                            // Display bounding boxes on top of the image
                            ForEach(detections, id: \.uuid) { detection in
                                BoundingBoxView(boundingBox: detection.boundingBox, imageSize: image.size, viewSize: geometry.size)
                            }
                        }
                    }.frame(height: 400)
                } else {
                    if isLoading {
                        ProgressView()
                            .padding(.horizontal, 24)
                            .padding(.vertical, 16)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.orange.opacity(0.3))
                            }
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
                }
            }
            HStack {
                Button {
                    withAnimation {
                        isLoading = true
                        showImagePicker = true
                        if image != nil {
                            self.image = nil
                            self.imageName = nil
                            self.detections = []
                            isLoading = false
                        }
                    }
                } label: {
                    if isLoading {
                        ProgressView()
                            .padding(.horizontal, 24)
                            .padding(.vertical, 16)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.orange.opacity(0.3))
                            }
                    } else {
                        Text("Choose from Gallery")
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Open Camera") {
                    showCamera.toggle()
                    showImagePicker = false
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
            isLoading = false
        } content: {
            ImagePicker(selectedImage: self.$image, imageName: self.$imageName).ignoresSafeArea()
        }
    }
}
