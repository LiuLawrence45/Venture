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
            
            VStack {
                VStack {
                        if images.isEmpty {
                            
                            TabView {
                                cover
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .frame(height: 460)
                            
                            // Default image or placeholder view
//                            Image("Background 2")
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .padding(20)
//                                
//                                .frame(maxHeight: 200)
//                                //.clipped()
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 30, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
//                                        .stroke(Color.clear, lineWidth: 2)
//                                )
//                                .clipShape(RoundedRectangle(cornerRadius: 30))
//                                .padding(10)
//                            
                            
                        } else {
                            // Snappy carousel using TabView
                            TabView(selection: $selectedIndex) {
                                ForEach(images.indices, id: \.self) { index in
                                    
                                    cover
                                    
//                                    cover
//                                        .zIndex(1)
//                                    
//                                    Image(uiImage: images[index])
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .padding(20)
//                                        .frame(width: UIScreen.main.bounds.width)
//                                        .clipped()
//                                        .cornerRadius(30)
//                                        .tag(index) // Tag each view with its index
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .frame(height: 460)
//                            .padding(20)
                        }

                    
                }
                .ignoresSafeArea()
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
                .accentColor(.primary)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .fixedSize(horizontal: false, vertical: true)
//                .padding(.vertical, 20)
//                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
//
//                .safeAreaInset(edge: .top) {
//                    Color.clear.frame(height: 70)
//                }
//                .padding(20)
                
                VStack(alignment: .center) {
                    Text("Hello")
                        .multilineTextAlignment(.center)
                        .font(.title3.weight(.semibold))
                    
                    Image("IMG_5186")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .padding(.bottom, 20)
                    
                    Text("Itinerary Caption")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .opacity(0.8)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                .padding(.horizontal, 20)
                
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
    
    
    var cover: some View {
        var inputImage: Image = Image("Background 2")
        return GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
            .foregroundStyle(.black)
            .background(
                ZStack {
                    Image("Background 2") 
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFill()
                        .offset(y: scrollY > 0 ? -scrollY : 0)
                        .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                        .blur(radius: scrollY / 10)
                        
                    
                    VStack {
                        Spacer()
                        Spacer()
                        Spacer()
                        VStack(alignment: .center, spacing: 12) {
                            Group {
                                Text("Post title")
                                    //.animatableFont(size: 34, weight: .bold )
                                    .font(.title.weight(.bold))
                                    //.opacity(0.5)
                                .frame(maxWidth: .infinity, alignment: .center)
                                Text("Post caption")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    //.opacity(0.5)
                                
                                HStack {
                                    Image("Avatar Default")
                                        .resizable()
                                        .frame(width: 26, height: 26)
                                        .cornerRadius(10)
                                        .padding(8)
                                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                                        .strokeStyle(cornerRadius: 18)
                                    Text("Itinerary edited by Lawrence Liu")
                                        .font(.footnote)
                                }
                            }
                            .offset(y: -20)

                        }
                        .padding(20)
                        .background(
                            Rectangle()
                                .fill(.ultraThinMaterial)
                                .blur(radius: 50 )
                        )
                        Spacer()
                    }
                    .foregroundStyle(.white)
                }

            )
            .mask(
                RoundedRectangle(cornerRadius: 0, style: .continuous)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
            )
        }
        .frame(height: 430 )

    }
}

struct PhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPicker()
    }
}
