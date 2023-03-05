//
//  ImagePicker.swift
//  LifeLoop
//
//  Created by 赵翔宇 on 2022/12/8.
//

import SwiftUI
struct PhotoSelector: UIViewControllerRepresentable {
    var images: [UIImage]
    var maxSelection: Int
    var completionHandler: (([UIImage]) -> Void)?

    init(maxSelection: Int, completionHandler: (([UIImage]) -> Void)?) {
        self.images = []
        self.maxSelection = maxSelection
        self.completionHandler = completionHandler
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: PhotoSelector

        init(_ parent: PhotoSelector) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let selectedImage = info[.editedImage] as? UIImage {
                parent.images.append(selectedImage)
            }

            // Call the completionHandler and pass the array of images
            parent.completionHandler?(parent.images)

            picker.dismiss(animated: true)
        }
    }
}

struct SinglePhotoSelector: UIViewControllerRepresentable {
    var image: UIImage?
    var completionHandler: ((UIImage?) -> Void)?
    init(image: UIImage? = nil, completionHandler: ((UIImage?) -> Void)?){
        self.image = image
        self.completionHandler = completionHandler
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: SinglePhotoSelector

        init(_ parent: SinglePhotoSelector) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let selectedImage = info[.editedImage] as? UIImage {
                parent.image = selectedImage
            }

            // Call the completionHandler and pass the selected image
            parent.completionHandler?(parent.image)

            picker.dismiss(animated: true)
        }
    }
}
