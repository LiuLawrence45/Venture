//
//  EditProfileView.swift
//  Venture
//
//  Created by Lawrence Liu on 3/2/24.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestore
import FirebaseStorage
import SDWebImageSwiftUI



struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var username = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var userBio = ""
    @State var school = ""
    @State var userBioLink = ""
    @State var profileDescription = ""
    @State var occupation = ""
    @State var gender = ""
    @State var email = ""
    @State var userProfilePicData: Data?
    
    @State var isLoading: Bool = false
    
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    @State private var myProfile: User?
    
    
    var body: some View {
        VStack {
            
            HStack{
                Spacer()
                ZStack {
                    if let userProfilePicData, let image = UIImage(data: userProfilePicData){
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 72, height: 72)
                            .mask(Circle())
                        
                    }
                    else {
                        WebImage(url: myProfile?.userProfileURL).placeholder{
                            Image("Avatar Default")

                        }
                        .resizable()
                        .frame(width: 72, height: 72)
                        .mask(Circle())
                        .aspectRatio(contentMode: .fill)

                    }
                }
                .onTapGesture {
                    showImagePicker.toggle()
                }
                Spacer()
            }
            .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
            .onChange(of: photoItem) { newValue in
                if let newValue {
                    Task {
                        do {
                            guard let imageData = try await newValue.loadTransferable(type: Data.self) else {
                                return
                            }
                            
                            await MainActor.run(body: {
                                userProfilePicData = imageData
                            })
                        }
                        catch{}
                    }
                }
                
            }
            
            
            Form {
                Section {
                    TextField("Username", text: $username)
                        .textContentType(.username)
                        .textInputAutocapitalization(.never)
                    TextField("First Name", text: $firstName)
                        .textContentType(.name)
                    TextField("Last Name", text: $lastName)
                        .textContentType(.name)
                }
                
                Section(footer: Text("This is information great to have displayed on your profile!")){
//                    TextField("Gender", text: $gender)
//                        .textContentType(.name)
                    TextField("School", text: $school)
                        .textContentType(.name)
                    TextField("Occupation", text: $occupation)
                        .textContentType(.name)
                    TextField("Profile Description", text: $profileDescription)
                        .textContentType(.username)
                        .textInputAutocapitalization(.never)
                }
            }
            
            
            Section {
                Button("Update profile") {
                    updateProfile()
                }
                .bold()
            }
            .navigationTitle("Update Profile")
            
        }
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        .task {
            if myProfile != nil {return}
            await fetchUserData()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Label("Back", systemImage: "chevron.backward")
                }
                
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                }) {
                    Label("Settings", systemImage: "ellipsis")
                }
                
            }
            
            
        }
        .tint(.primary)

    }
    
    func fetchUserData() async {
        guard let userUID = Auth.auth().currentUser?.uid else {return}
        let user = try? await Firestore.firestore().collection("Users").document(userUID).getDocument(as: User.self)
        
        await MainActor.run(body: {
            myProfile = user
            username = myProfile?.username ?? ""
            firstName = myProfile?.firstName ?? ""
            lastName = myProfile?.lastName ?? ""
            school = myProfile?.school ?? ""
            userBioLink = myProfile?.userBioLink ?? ""
            profileDescription = myProfile?.userBio ?? ""
            occupation = myProfile?.occupation ?? ""
            gender = myProfile?.gender ?? ""
            email = myProfile?.userEmail ?? ""
//            userProfileURL = myProfile.userProfileURL ??
            
        })
    }
    
    func updateProfile() {
        isLoading = true
        Task{
            do {
                //Upload picture to Firebase
                guard let userUID = Auth.auth().currentUser?.uid else{print("Failed to get user UID")
                    return}
                
                print("User UID: \(userUID)")
                
                var downloadURL: URL?
                var storageRef = Storage.storage().reference().child("Profile_Images").child("Avatar Default.jpg")
                //Uploading and downloading PhotoURL.
                if let imageData = userProfilePicData {
                    storageRef = Storage.storage().reference().child("Profile_Images").child(userUID)
                    
                    let _ = try await storageRef.putDataAsync(imageData)
                    downloadURL = try await storageRef.downloadURL()
                }
                    
                else {
                    print ("No input image assigned")
                    downloadURL = self.myProfile?.userProfileURL ?? profileURL
                    //return
                }
                
//                //Download Photo URL
                print("Download URL: \(downloadURL)")
        
                
                let user = User(username: username, firstName: firstName, lastName: lastName, userBio: profileDescription, school: school,  userEmail: email, userProfileURL: downloadURL, occupation: occupation)
                
                let _ = try Firestore.firestore().collection("Users").document(userUID).setData(from: user, completion: {
                    error in
                    if error == nil {
                        print("Saved successfully")
                        userNameStored = username
                        self.userUID = userUID
                        profileURL = downloadURL
                        logStatus = true
                    }
                })
                
                await MainActor.run {
                    isLoading = false
                }

            }
            catch {
                await setError(error)
            }
        }
        
        func setError(_ error: Error) async {
            await MainActor.run(body:  {
                errorMessage = error.localizedDescription
                showError.toggle()
            })
            isLoading = false
        }
    }
    
  
    
}


struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
            .environmentObject(Model())
    }
}
