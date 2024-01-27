import SwiftUI
import PhotosUI

struct AlternatePhotoPicker: View {
    @State var selectedItems: [PhotosPickerItem] = []
    @State private var hasScrolled = false
    @State private var images: [UIImage] = [] // Hold multiple images
    @State private var selectedIndex: Int = 0 // Track the currently visible image's index
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            VStack {
                
                Group {
                    
                    if images.isEmpty {
                        // Default image or placeholder view
                        Image("Background 2")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(20)
                            .frame(maxHeight: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .padding(10)
                    } else {
                        // Snappy carousel using TabView with indices
                        TabView(selection: $selectedIndex) {
                            ForEach(images.indices, id: \.self) { index in
                                VStack {
                                    Image(uiImage: images[index])
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .padding(20)
                                        .frame(width: UIScreen.main.bounds.width)
                                        .clipped()
                                        .cornerRadius(30)
                                    
                                    // Customized prompt showing the index
                                    Text("Photo \(index + 1) of \(images.count)")
                                        .font(.headline)
                                        .padding(.bottom, 10)
                                }
                                .tag(index) // Tag each view with its index
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        .frame(height: 250) // Adjusted height to accommodate the index text
                        .padding(20)
                    }
                }
                PhotosPicker(
                    selection: $selectedItems,
                    matching: .images
                ) {
                    HStack {
                        Image(systemName: "pencil.and.outline").dynamicTypeSize(.xxLarge)
                        Text("Choose Photos to Upload")
                    }
                }
                .onChange(of: selectedItems) { _ in
                    loadImages()
                }
                .padding(20)
                .accentColor(.primary)
                
                Spacer()
            }
            .scrollClipDisabled() //iOS 17.0
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 70)
            }
            .background(
                Image("Blob 1").offset(x: -400 , y: -300)
            )
        }
        .overlay(NavigationBar(title: "Document", hasScrolled: .constant(true)))
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

struct AlternatePhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        AlternatePhotoPicker()
    }
}