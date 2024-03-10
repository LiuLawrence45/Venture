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
    
    let presetAspectRatio = CGSize(width: 4, height: 5)
    
    func makeUIViewController(context: Context) -> UIViewController {
        let cropViewController = TOCropViewController(croppingStyle: .default, image: image ?? UIImage())
        cropViewController.delegate = context.coordinator
        
        // Setting the aspect ratio preset
//       cropViewController.customAspectRatio = presetAspectRatio
       
       // If you want to force users to use the preset aspect ratio without the ability to adjust it
//       cropViewController.aspectRatioLockEnabled = true // This locks the aspect ratio
//       cropViewController.resetAspectRatioEnabled = false // This disables the ability to reset the aspect ratio to a different one
       
       // Optionally, you can also set the aspectRatioPickerButtonHidden to true if you want to hide the button that allows users to select different aspect ratios.
//       cropViewController.aspectRatioPickerButtonHidden = true
        
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
