//
//  CreateNewPost.swift
//  Venture
//
//  Created by Lawrence Liu on 3/5/24.
//

import SwiftUI
import PhotosUI

struct CreateNewPost: View {
    
    //Callbacks
    var onPost: (Post) -> ()
     
    //Post Properties
    @State private var postText: String = ""
    @State private var postImageData: Data?
    
    
    //Stored User Defaults
    @AppStorage("user_profile_url") private var profileURL: URL?
    @AppStorage("user_name") private var userName: String = ""
    @AppStorage("user_UID") private var userUID: String = ""
    
    //View Properties
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var showImagePicker: Bool = false
    @State private var photoItem: PhotosPickerItem?
    @FocusState private var showKeyboard: Bool //Focus state is used to toggle the keyboard on and off
    
    
    //Body
    var body: some View {
        VStack {
            HStack {
                Menu {
                    Button("Cancel", role: .destructive){
                        dismiss()
                    }
                } label: {
                    Text("Cancel")
                        .font(.callout)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("Post")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 6)
                        .background(.black, in: Capsule())
                }
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15){
                    if let postImageData, let image = UIImage(data: postImageData){
                        GeometryReader {
                            let size = $0.size
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
//                                .clipShape()
                                .overlay(alignment: .topTrailing){
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.25)){
                                            self.postImageData = nil
                                        }
                                        
                                    } label: {
                                        Image(systemName: "trash")
                                            .fontWeight(.bold)
                                            .tint(.red)
                                    }
                                    .padding(10)
                                }
                        }
                        .clipped()
                        .frame(height: 220)
                    }
                    
                    TextField("What's happening?", text: $postText, axis: .vertical)
                        .focused($showKeyboard)

                }
                .padding(15)
            }
            
            Divider()
            
            HStack {
                Button {
                    showImagePicker.toggle()
                    
                } label: {
                    Image(systemName: "photo.on.rectangle")
                        .font(.title3)
                        .foregroundColor(.primary)
                }
                Spacer()
                
                Button("Done"){
                    showKeyboard = false
                    
                }

            }
            .accentColor(.primary)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            
            Spacer()
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background {
            Rectangle()
                .fill(.gray.opacity(0.05))
                .ignoresSafeArea()
        }
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem) { newValue in
            if let newValue {
                Task {
                    if let rawImageData = try? await newValue.loadTransferable(type: Data.self),
                       let image = UIImage(data: rawImageData),
                       let compressedImageData = image.jpegData(compressionQuality: 0.5){
                        
                        // UI must be done on main thread
                        await MainActor.run(body: {
                            postImageData = compressedImageData
                            photoItem = nil
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    CreateNewPost{_ in
        
    }
}
