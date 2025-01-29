//
//  CameraView.swift
//  MLSwift
//
//  Created by Mustafa Bekirov on 10.02.2025.
//

import SwiftUI
import AVFoundation
import CoreML
import Vision

struct CameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var detections: [VNRecognizedObjectObservation]

    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        var parent: CameraView
        private let model = YOLOv3Model()

        init(parent: CameraView) {
            self.parent = parent
        }

        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            let ciImage = CIImage(cvPixelBuffer: imageBuffer)
            let uiImage = UIImage(ciImage: ciImage)

            // Запуск детекции светофоров в реальном времени
            detectTrafficLights(in: uiImage)
        }

        func detectTrafficLights(in image: UIImage) {
            model.detectObjects(in: image) { observations in
                // Фильтруем результаты для светофоров
                let trafficLights = observations.filter { observation in
                    return observation.labels.contains { $0.identifier == "traffic_light" }
                }

                // Обновление данных о детекции
                DispatchQueue.main.async {
                    self.parent.detections = trafficLights // Обновляем список детекций
                    self.parent.image = image // Обновляем изображение
                }
            }
        }
    }

    let session = AVCaptureSession()

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = viewController.view.bounds
        viewController.view.layer.addSublayer(previewLayer)

        let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        if let device = captureDevice {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) { session.addInput(input) }

                let output = AVCaptureVideoDataOutput()
                output.setSampleBufferDelegate(context.coordinator, queue: DispatchQueue(label: "cameraQueue"))
                if session.canAddOutput(output) { session.addOutput(output) }

                // Стартуем сессию на фоне
                DispatchQueue.global(qos: .userInteractive).async {
                    self.session.startRunning()
                }
            } catch {
                print("Error setting up camera: \(error)")
            }
        }

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
