import SwiftUI
import PhotosUI

struct AlternateAgainPhotoPicker: View {
    @State var selectedItems: [PhotosPickerItem] = []
    @State private var hasScrolled = false
    @State private var images: [UIImage] = [] // Hold multiple images
    @State private var selectedIndex: Int = 0 // Track the currently visible image's index
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            VStack{
                VStack {
                        if images.isEmpty {
                            TabView {
                                VStack(alignment: .center) {
                                    Text("📍 Enter Category")
                                        .multilineTextAlignment(.center)
                                        .font(.title3.weight(.semibold))
                                    
                                    Image("Background 1")
                                        .resizable()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 200)
                                        .padding(.bottom, 20) 
                                    
//                                    Text("Itinerary Caption")
//                                        .font(.subheadline)
//                                        .foregroundColor(.primary)
//                                        .opacity(0.8)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 20)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                                .padding(20)
                            }
                            .tabViewStyle(.page)
                            .frame(height: 320)

                            
                        } else {
                            // Snappy carousel using TabView
                            TabView(selection: $selectedIndex) {
                                ForEach(images.indices, id: \.self) { index in
                                    
                                    
                                    VStack(alignment: .center) {
                                        Text("📍 Enter Category")
                                            .multilineTextAlignment(.center)
                                            .font(.title3.weight(.semibold))
                                        
                                        Image(uiImage: images[index])
                                            .resizable()
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 200)
                                            .padding(.bottom, 20)
                                        
//                                        Text("Itinerary Caption")
//                                            .font(.subheadline)
//                                            .foregroundColor(.primary)
//                                            .opacity(0.8)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 20)
                                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                                    .padding(20)
                                    
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .frame(height: 320)

                        }

                    
                }

                PhotosPicker(
                    selection: $selectedItems,
                    matching: .images
                ) {
                    HStack(alignment: .top){
                        Image(systemName: "pencil.and.outline").dynamicTypeSize(.xxLarge)
                        Text("Choose Photos to Upload")
                    }
                    .foregroundColor(.secondary)
                    
                    
                }
                .onChange(of: selectedItems) { _ in
                    loadImages()
                }
                .accentColor(.primary)
                .padding(.bottom, 20)
                HStack {
                    Text("📍 Add Location")
                    Spacer()
                    
                }
                .padding(20)
                
                Spacer()
                
            }
            

        }
        //.overlay(NavigationBar(title: "Document", hasScrolled: .constant(true)))
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

struct AlternateAgainPhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        AlternateAgainPhotoPicker()
    }
}
