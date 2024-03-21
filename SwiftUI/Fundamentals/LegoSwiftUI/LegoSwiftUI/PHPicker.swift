//
//  PHPickerView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 18.03.2024.
//

import SwiftUI
import PhotosUI

var preselectedAssetIdentifiers = [String]()

struct PHPickerView: View {
    @State private var showPicker: Bool = false
    
    var pickerConfig: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 20
        config.preferredAssetRepresentationMode = .current
        config.preselectedAssetIdentifiers = preselectedAssetIdentifiers
        return config
    }
    var body: some View {
        VStack {
            Button("PHPicker") {
                showPicker.toggle()
            }
            .sheet(isPresented: $showPicker, content: {
                PHPickerSwiftUI(config: pickerConfig) {
                    selectedImages in
                    processSelectedImages(results: selectedImages)
                }
                .ignoresSafeArea()
            })
        }
        .padding()
    }
    
    func processSelectedImages(results: [PHPickerResult]) {
        
    }
}

#Preview {
    PHPickerView()
}

struct PHPickerSwiftUI: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    let config: PHPickerConfiguration
    let completion: (_ selectedImages: [PHPickerResult]) -> Void
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        let parent: PHPickerSwiftUI
        
        init(parent: PHPickerSwiftUI) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            preselectedAssetIdentifiers = results.map(\.assetIdentifier!)
            
            self.parent.completion(results)
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
