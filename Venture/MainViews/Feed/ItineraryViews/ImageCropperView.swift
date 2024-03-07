//
//  ImageCropperView.swift
//  Venture
//
//  Created by Lawrence Liu on 3/6/24.
//

import SwiftUI
import TOCropViewController

struct ImageCropperView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var image: UIImage?
    var completion: (UIImage?) -> Void
    
    func makeUIViewController(context: Context) -> UIViewController {
        let cropViewController = TOCropViewController(croppingStyle: .default, image: image ?? UIImage())
        cropViewController.delegate = context.coordinator
        return cropViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, TOCropViewControllerDelegate {
        var parent: ImageCropperView
        
        init(_ parent: ImageCropperView) {
            self.parent = parent
        }
        
        func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
            parent.completion(image)
            parent.isPresented = false
        }
        
        func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
            parent.isPresented = false
        }
    }
}
