//
//  ImagePicker.swift
//  Vikings
//
//  Created by Dmitriy Permyakov on 26/10/2023.
//

import SwiftUI

struct ImagePickerForPriview: View {

    @State private var showImagePicker = false
    @State private var image: UIImage = UIImage(systemName: "camera")!

    var body: some View {
        VStack {

            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .foregroundStyle(.white)

            Button {
                showImagePicker.toggle()

            } label: {
                Text("Show image picker")
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker() { image in
                    self.image = image
                    print(image)
                }
            }
        }
    }
}

#Preview {
    ImagePickerForPriview()
}

// MARK: - ImagePicker view controller

struct ImagePicker: UIViewControllerRepresentable {

    var completion: (UIImage) -> Void

    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    final class Coordinator: NSObject {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension ImagePicker.Coordinator: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
//            parent.image = selectedImage
            parent.completion(selectedImage)
        }
        picker.dismiss(animated: true)
    }
}

// MARK: - UINavigationControllerDelegate

extension ImagePicker.Coordinator: UINavigationControllerDelegate {

}
