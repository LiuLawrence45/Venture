//
//  PhotoPicker.swift
//  Venture
//
//  Created by Lawrence Liu on 1/26/24.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: View {
    @State var selectedItems: [PhotosPickerItem] = []
    @State var hasScrolled = false
    @State var data: Data?
    
    var body: some View {
        
        
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false, content: {
                if let data = data, let uiimage = UIImage(data: data) {
                    
                    Image(uiImage: uiimage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(.horizontal, 20)
                        .frame(width: UIScreen.main.bounds.width)
                        .clipped()
                        .mask(
                            RoundedRectangle(cornerRadius: 30, style: .continuous))

//                    Image(uiImage: uiimage)
//                        .resizable()
                }
                PhotosPicker(
                    selection: $selectedItems,
                    matching: .images // can change later to all
                ) {
                    Text("Pick photo")
                }
                .onChange(of: selectedItems) { newValue in
                    guard let item = selectedItems.first else {
                        return
                    }
                    item.loadTransferable(type: Data.self) { result in
                        switch result {
                        case .success(let data):
                            if let data = data {
                                self.data = data
                            }
                            else {
                                print("Data is nil")
                            }
                        case .failure(let failure):
                            fatalError("\(failure)")
                        }
                    }
                }
                
            })
            .scrollClipDisabled() //iOS 17.0
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 70)
            }
            .overlay(NavigationBar(title: "Document", hasScrolled: .constant(true)))

            //.background(Image("Blob 1").offset(x: -100, y: -400))
        }
        

    }
}


struct PhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPicker()
    }
}
