import SwiftUI
import PhotosUI

struct PhotoPicker: View {
    @Binding var selectedItems: [PhotosPickerItem]
    @State private var hasScrolled = false
    @State private var images: [UIImage] = [] // Hold multiple images
    @State private var selectedIndex: Int = 0 // Track the currently visible image's index
    
    
    @State private var description: String = ""
    @State private var location: String = ""
    @State private var cost: String = ""
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView{
                Spacer().frame(height: 80)
                VStack {
                    
                    TabView(selection: $selectedIndex) {
                        ForEach(images.indices, id: \.self) { index in
                            
                            
                            VStack(alignment: .center) {
                                Text("✌️ Enter Title")
                                    .multilineTextAlignment(.center)
                                    .font(.title3.weight(.semibold))
                                
                                Image(uiImage: images[index])
                                    .resizable()
                                    .frame(maxWidth: .infinity)
                                    .aspectRatio(contentMode: .fill)
                                    
                                    .frame(height: 200)
                                    .padding(.bottom, 20)
                                    .clipped()
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
                    
//                        if images.isEmpty {
//                            TabView {
//                                VStack(alignment: .center) {
//                                    Text("Upload Photos!")
//                                        .multilineTextAlignment(.center)
//                                        .font(.title3.weight(.semibold))
//                                    
//                                    Image("Default")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .frame(maxWidth: .infinity)
//                                        .frame(height: 200)
//                                        .clipped()
//                                        .padding(.bottom, 20)
//                                }
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .fixedSize(horizontal: false, vertical: true)
//                                .padding(.horizontal, 20)
//                                .padding(.vertical, 20)
//                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
//                                .padding(.horizontal, 10)
//                                .padding(.vertical, 20)
//                            }
//                            .tabViewStyle(.page)
//                            .frame(height: 320)
//
//                            
//                        } else {
//                            TabView(selection: $selectedIndex) {
//                                ForEach(images.indices, id: \.self) { index in
//                                    
//                                    
//                                    VStack(alignment: .center) {
//                                        Text("✌️ Enter Title")
//                                            .multilineTextAlignment(.center)
//                                            .font(.title3.weight(.semibold))
//                                        
//                                        Image(uiImage: images[index])
//                                            .resizable()
//                                            .frame(maxWidth: .infinity)
//                                            .aspectRatio(contentMode: .fill)
//                                            
//                                            .frame(height: 200)
//                                            .padding(.bottom, 20)
//                                            .clipped()
//                                    }
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    
//                                    .fixedSize(horizontal: false, vertical: true)
//                                    .padding(.horizontal, 10)
//                                    .padding(.vertical, 20)
//                                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
//                                    .padding(20)
//                                    
//                                }
//                            }
//                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//                            .frame(height: 320)
//
//                        }

                    
                }
                
                Divider()
                    .padding(.bottom, 10)
                
                VStack(alignment: .center) {
                    TextField("_Add Description Here..._", text: $description)
                        .foregroundStyle(.secondary)
                        .padding(.leading, 20)
                }
                .padding(.bottom, 10)
                
                Divider()
                
                HStack(spacing: 0){
                    Text("📍")
                    TextField(" _Location!_", text: $location)
                    Spacer()
                     
                }
                .font(.callout)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
                
                HStack {
                    Text("🤑")
                    TextField(" _Cost!_", text: $cost)
                    Spacer()
                    
                }
                .font(.callout)
                .foregroundStyle(.secondary)
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
                    Task {
                       await loadImages()
                    }

                }
                .accentColor(.primary)
                .frame(alignment: .bottomTrailing)
 // Add padding at the bottom equal to the safe area inset
                .offset(x: 140)
                .offset(y: UIScreen.main.bounds.height - 820)
//                .offset(x: 140)
//                .offset(y: 40)
                
                
                Spacer()
                
                Spacer()
                
            }
            

        }
        
        .overlay(NavigationBar(title: "Your Venture", hasScrolled: .constant(true)))
        .task {
            await loadImages() // Run asynchronously when the view appears
        }
    }
    
    func loadImages() async {
        // First, clear the existing images
        images.removeAll()

        // Use asynchronous loading for each selected item
        for item in selectedItems {
            await withCheckedContinuation { continuation in
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.images.append(image) // Append new image
                            }
                        }
                    case .failure(let error):
                        print("Error loading image: \(error.localizedDescription)")
                    }
                    continuation.resume()
                }
            }
        }
    }
}

//struct PhotoPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoPicker(selectedItems: .constant([]))
//    }
//}
