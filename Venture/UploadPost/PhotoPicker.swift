import SwiftUI
import PhotosUI

struct PhotoPicker: View {
    @State var selectedItems: [PhotosPickerItem] = []
    @State private var hasScrolled = false
    @State private var images: [UIImage] = [] // Hold multiple images
    @State private var selectedIndex: Int = 0 // Track the currently visible image's index
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                if images.isEmpty {
                    // Default image or placeholder view
                    Image("Background 2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(.horizontal, 20)
                        .frame(width: UIScreen.main.bounds.width)
                        .clipped()
                        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                } else {
                    // Snappy carousel using TabView
                    TabView(selection: $selectedIndex) {
                        ForEach(images.indices, id: \.self) { index in
                            Image(uiImage: images[index])
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .padding(.horizontal, 20)
                                .frame(width: UIScreen.main.bounds.width)
                                .clipped()
                                .cornerRadius(30)
                                .tag(index) // Tag each view with its index
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(height: 200)
                }
                
                PhotosPicker(
                    selection: $selectedItems,
                    matching: .images
                ) {
                    Text("Pick photo")
                }
                .onChange(of: selectedItems) { _ in
                    loadImages()
                }
            }
            .scrollClipDisabled() //iOS 17.0
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 70)
            }
            .overlay(NavigationBar(title: "Document", hasScrolled: .constant(true)))
        }
    }
    
    func loadImages() {
        images = [] // Clear existing images
        for item in selectedItems {
            item.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let data):
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.images.append(image)
                        }
                    } else {
                        print("Data is nil or cannot be converted to UIImage")
                    }
                case .failure(let failure):
                    print("Failed to load image: \(failure)")
                }
            }
        }
    }
}

struct PhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPicker()
    }
}
