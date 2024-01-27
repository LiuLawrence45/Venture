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
            
            VStack{
                Spacer()
                VStack {
                        if images.isEmpty {
                            TabView {
                                VStack(alignment: .center) {
                                    Text("Upload Photos!")
                                        .multilineTextAlignment(.center)
                                        .font(.title3.weight(.semibold))
                                    
                                    Image("Background 1")
                                        .resizable()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 200)
                                        .padding(.bottom, 20)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 20)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 20)
                            }
                            .tabViewStyle(.page)
                            .frame(height: 320)

                            
                        } else {
                            TabView(selection: $selectedIndex) {
                                ForEach(images.indices, id: \.self) { index in
                                    
                                    
                                    VStack(alignment: .center) {
                                        Text("✌️ Enter Title")
                                            .multilineTextAlignment(.center)
                                            .font(.title3.weight(.semibold))
                                        
                                        Image(uiImage: images[index])
                                            .resizable()
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 200)
                                            .padding(.bottom, 20)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 20)
                                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                                    .padding(20)
                                    
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .frame(height: 320)

                        }

                    
                }
                
                Divider()
                    .padding(.bottom, 10)
                
                VStack(alignment: .center) {
                    Text("_Add Description Here..._")
                        .foregroundStyle(.secondary)
                }
                .padding(.bottom, 10)
                
                Divider()
                
                HStack {
                    Text("📍 _Location!_")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    Spacer()
                     
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
                
                HStack {
                    Text("🤑 _Cost!_")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                //.background(.ultraThinMaterial, in: Rectangle())
                .offset(y: -5)
                .padding(.horizontal, 10)
                
                PhotosPicker(
                    selection: $selectedItems,
                    matching: .images
                ) {
                    HStack(alignment: .top){
                        //Image(systemName: "pencil.and.outline").dynamicTypeSize(.xxLarge)
                        Image(systemName: "pencil.and.outline")
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(maxWidth: 12)
                            .frame(maxHeight: 24)
                        
                        //Text("Choose Photos to Upload")
                    }
                    .background(
                        Circle()
                            .frame(width: 64, height: 64)
                            .opacity(0.4)
                    )
                    
                    .foregroundColor(.secondary)
                    
                    
                }
                .onChange(of: selectedItems) { _ in
                    loadImages()
                }
                .accentColor(.primary)
                .frame(alignment: .bottomTrailing)
                .offset(x: 140)
                .offset(y: 40)
                
                
                Spacer()
                
                Spacer()
                
            }
            

        }
        .overlay(NavigationBar(title: "Your Venture", hasScrolled: .constant(true)))
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
