//
//  CreateNewPost.swift
//  Venture
//
//  Created by Lawrence Liu on 3/5/24.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage

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
    @State private var showError: Bool = false
    
    
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
                
                Button(action: {createPost()}) {
                    Text("Post")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 6)
                        .background(.primary, in: Capsule())
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
            
            Group {
                
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

        //Programmable photosPicker
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        
        //Programmable
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
        
        //Error alert
        .alert(errorMessage, isPresented: $showError, actions: {})
        
        //Loading View
        .overlay {
            LoadingView(show: $isLoading)
        }
        
    }
    
    //Post content to FireBase
    func createPost(){
        isLoading = true
        showKeyboard = false
        
        Task {
            do {
                guard let profileURL = profileURL else {return}
                
                //Uploading image, if any
                let imageReferenceID = "\(userUID)\(Date())"
                let storageRef = Storage.storage().reference().child("Post_Images").child(imageReferenceID)
                
                if let postImageData{
                    let _ = try await storageRef.putDataAsync(postImageData)
                    let downloadURL = try await storageRef.downloadURL()
                    
                    let post = Post(text: postText, imageURL: downloadURL, imageReferenceID: imageReferenceID, userName: userName, userUID: userUID, userProfileURL: profileURL)
                    
                    try await createDocumentAtFirebase(post)
                    
                } else {
                    //Directly post text data to Firebase (since there are no images)
                    let post = Post(text: postText, userName: userName, userUID: userUID, userProfileURL: profileURL)
                    
                    try await createDocumentAtFirebase(post)
                }
            }
            
            catch {
                
            }
        }
    }
    
    func createDocumentAtFirebase(_ post: Post) async throws {
        
        //Write the document to Firebase
        
        let _ = try Firestore.firestore().collection("Posts").addDocument(from: post, completion: {error in
            if error == nil {
                //Post successfully stored
                isLoading = false
                onPost(post)
                dismiss()
            }
        })
        
    }
    
    func setError(_ error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

#Preview {
    CreateNewPost{_ in
        
    }
}