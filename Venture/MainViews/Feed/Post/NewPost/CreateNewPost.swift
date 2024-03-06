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
import CoreLocation

struct CreateNewPost: View {
    
    //Callbacks
    var onPost: (Post) -> ()
    

    
    
    //Stored User Defaults
    @AppStorage("user_profile_url") private var profileURL: URL?
    @AppStorage("user_name") private var userName: String = ""
    @AppStorage("user_UID") private var userUID: String = ""
    
    //View Properties
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var showImagePicker: Bool = false
    @State private var photoItems: [PhotosPickerItem] = []
    @FocusState private var showKeyboard: Bool //Focus state is used to toggle the keyboard on and off
    @State private var showError: Bool = false
    @State private var showModal = false
    
    
    //Post Properties
    @State private var postCaption: String = ""
    @State private var postImageData: [Data] = []
    @State private var postTitle: String = ""
    @State private var postLocation: String = "Add location"
    @State private var tripCost: String = ""
    @State private var tripCar: Bool = false
    
    
    //Body
    var body: some View {
        VStack {
            
            //Top of the post (cancel, and Post buttons)
            HStack {
                Button {
                    dismiss()
                }
            label: {
                Text("Cancel")
                    .font(.callout)
                    .opacity(0.7)
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
            
            //Carousel for pictures, and "Description"
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15){
                    
                    PostCarousel(postImageData: $postImageData)
                    
                    
                    //Add Title
                    HStack(spacing: 15){
                        Text("🌱")
                        TextField("Type in a quick title!", text: $postTitle, axis: .vertical)
                            .focused($showKeyboard)
                    }
                    
                    //Purely decorative
                    HStack {
                        Text("|")
                            .offset(x: 10)
                            .opacity(0.2)
                        Spacer()
                    }

                    
                    //Quick Caption (postText)
                    HStack(spacing: 15) {
                        Text("🎤")
                        TextField("Need a caption too...", text: $postCaption, axis: .vertical)
                            .focused($showKeyboard)
                    }

                    
                    Divider()
                        .padding(.vertical, 10)
                    
                    //Adding automated location
                    HStack(spacing: 15){
                           Text("📍")
                           Text(postLocation)
                            .opacity(0.2)
                           Spacer()
                           Image(systemName: "chevron.right")
                    }
                    .onTapGesture {
                        self.showModal = true
                    }
                    .fullScreenCover(isPresented: $showModal) {
                        LocationPickerView(isPresented: self.$showModal, selectedLocation: self.$postLocation)
                    }
                    
                    Divider()
                        .padding(.vertical, 10)
                    
                    Text("Trip Details")
                        .fontWeight(.bold)
                        .font(.title3)
                        .padding(.bottom, 10)
                     
                    //Add Costs; has some sketchy logic for allowing only numbers in
                    HStack(spacing: 15){
                        Text("💸")
                        TextField("Cost for trip per person", text: $tripCost, axis: .vertical)
                            .keyboardType(.numberPad)
                            .focused($showKeyboard)
                            .onReceive(tripCost.publisher.collect()) {
                                self.tripCost = String($0.prefix(while: { $0.isNumber }))
                            }
                    }
                    
                    //Purely decorative
                    HStack {
                        Text("|")
                            .offset(x: 10)
                            .opacity(0.2)
                        Spacer()
                    }
                    
                    //Quick Caption (postText)
                    HStack(spacing: 15) {
                        Text("🚗")
                        Toggle(isOn: $tripCar){
                            HStack{
                                Text("Car Needed?")
                                    .opacity(0.2)
                                if tripCar == false {
                                    Text("Nope!")
                                        .opacity(0.2)
                                }
                                else {
                                    Text("Yep!")
                                        .opacity(0.2)
                                }
                            }
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .primary))
                        
                    }
                    
                    
                    
                    
                    

//                    HStack {
//                        Image(systemName: "pencil.circle.fill")
//                        Text("Add a title")
//                        Spacer()
//                        Text("\(postTitle.count) / 80")
//                    }
//                    .padding()
//                    .onTapGesture {
//                        self.showTitleScreen = true
//                    }
//                    .sheet(isPresented: $showTitleScreen) {
//                        TitleEntryView(titleText: self.$titleText)
//                    }
                    
                    

                     
                }
                .padding(15)
                
            }
            
            //
            
            Divider()
            
            HStack {
                Button {
                    showImagePicker.toggle()
                    
                } label: {
                    HStack {
                        Text("Upload Images")
                        Image(systemName:  "photo.on.rectangle")
                            .font(.caption)
                            .foregroundColor(.primary)
                    }

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
//        .background {
//            Rectangle()
//                .fill(.gray.opacity(0.05))
//                .ignoresSafeArea()
//        }
        
        
        //Programmable photosPicker
        .photosPicker(isPresented: $showImagePicker, selection: $photoItems, matching: .images)
        
        //Programmable
        .onChange(of: photoItems) { _ in
            processSelectedPhotos()
        }
        
        //Error alert
        .alert(errorMessage, isPresented: $showError, actions: {})
        
        //Loading View
        .overlay {
            LoadingView(show: $isLoading)
        }
        
    }
    
    //Processing selected Photos from the photoItems array. Adds all images from photoItems from photoItemPicker to the postImageData.
    func processSelectedPhotos(){
        Task {
            for photoItem in photoItems {
                if let rawImageData = try? await photoItem.loadTransferable(type: Data.self),
                   let image = UIImage(data: rawImageData),
                   let compressedImageData = image.jpegData(compressionQuality: 0.5){
                    
                    await MainActor.run(body: {
                        postImageData.append(compressedImageData)
                    })
                }
                
            }
        }
    }
    
    //Post content to FireBase
    func createPost(){
        isLoading = true
        showKeyboard = false
        
        Task {
            do {
                guard let profileURL = profileURL else {return}
                
                
                //If there exists imageData within the post.
                if let _ = postImageData.first{
                    
                    //Overall image reference ID
                    let imageReferenceID = "\(userUID)\(Date())"
                    
                    //Uploading image, if any
                    var imageURLs = [URL]()
                    
                    for (index, individualImage) in postImageData.enumerated() {
                        let uniqueImageID = "\(imageReferenceID)_\(index)"
                        let storageRef = Storage.storage().reference().child("Post_Images").child(uniqueImageID)
                        
                        let _ = try await storageRef.putDataAsync(individualImage)
                        let downloadURL = try await storageRef.downloadURL()
                        imageURLs.append(downloadURL)
                    }
                    
                    let post = Post(caption: postCaption, imageURLs: imageURLs, imageReferenceID: imageReferenceID, userName: userName, userUID: userUID, userProfileURL: profileURL)
                    
                    try await createDocumentAtFirebase(post)
                    
                }
                
                
                //If there is no image data provided.
                else {
                    isLoading = false
                    throw AtLeastOneImage.withMessage("Please add at least one image to your post.")
                }
            }
            
            catch {
                await setError(error)
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
    
    //Custom error
    enum AtLeastOneImage: Error {
        case withMessage(String)
    }
    
    func setError(_ error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

// Struct PostCarousel; separated to increase loading speeds. If need to increase more, make it equatable.

struct PostCarousel: View {
    
    @Binding var postImageData: [Data]
    var body: some View {
        //Horizontal carousel of images
        ScrollView(.horizontal, showsIndicators: false){
            
            //Apparently this is faster than an HStack.
            LazyHStack {
                
                //Looping through each image provided.
                ForEach(postImageData.indices, id: \.self) { index in
                    if let image = UIImage(data: postImageData[index]){
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 128, height: 128)
                            .clipped()
                            .cornerRadius(8)
                        
                        //Trash overlay, to remove image.
                            .overlay(alignment: .topTrailing) {
                                Button {
                                    withAnimation {
                                        self.removeImage(at: index)
                                        
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                        .padding(10)
                                        .foregroundColor(.red)
                                }
                            }
                    }
                    
                }
            }
        }
    }
    
    //Helper function to remove an image from photoImageData. Does not currently work for non-last images.
    func removeImage(at index: Int) {
        postImageData.remove(at: index)
    }
    
}

#Preview {
    CreateNewPost{_ in
        
    }
}
