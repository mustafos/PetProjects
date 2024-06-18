//
//  ImagePickerLibrary.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 17.06.2024.
//

import SwiftUI

struct ImagePickerLibrary: View {
    @State private var image = UIImage()
    @State private var showSheet = false
    @State private var imageName: String = ""
    
    var body: some View {
        HStack {
            VStack(spacing: 12) {
                Image(uiImage: self.image)
                    .resizable()
                    .cornerRadius(50)
                    .padding(.all, 4)
                    .frame(width: 100, height: 100)
                    .background(Color.black.opacity(0.2))
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .padding(8)
                
                Text(imageName).font(.callout)
            }
            Text("Change photo")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(16)
                .foregroundColor(.white)
        }
        .onTapGesture {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image, imageName: self.$imageName)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage
    @Binding var imageName: String // Binding to update image name

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
                parent.imageName = "IMG\(UUID().uuidString.prefix(4))"
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
