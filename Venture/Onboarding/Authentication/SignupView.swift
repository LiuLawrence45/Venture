//
//  SignupView.swift
//  SignupView
//
//  Created by Meng To on 2021-07-27.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct SignupView: View {
    @EnvironmentObject var model: Model
    @State var email = ""
    @State var username = ""
    @State var password = ""
    @State var userProfilePicData: Data?
    @State var circleInitialY = CGFloat.zero
    @State var circleY = CGFloat.zero
    @FocusState var isUsernameFocused: Bool
    @FocusState var isPasswordFocused: Bool
    @FocusState var isEmailFocused: Bool
    @State var appear = [false, false, false]
    var dismissModal: () -> Void
    
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    @State var isLoading: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Welcome to Weeknd")
//                .font(.largeTitle).bold()
                .font(.custom("Michroma-Regular", size: 32))
//                .font(.custom("Raleway", size: 32))
                .slideFadeIn(show: appear[0], offset: 30)
            
            Text("We're glad you're here.")
                .font(.headline)
                .font(.custom("Michroma-Regular", size: 18))
                .foregroundColor(.primary.opacity(0.7))
                .slideFadeIn(show: appear[1], offset: 20)
            
            form.slideFadeIn(show: appear[2], offset: 10)
        }
        .alert(errorMessage, isPresented: $showError, actions: {})
        .coordinateSpace(name: "stack")
        .padding(20)
        .padding(.vertical, 20)
        .background(.ultraThinMaterial)
        .backgroundColor(opacity: 0.4)
        .cornerRadius(30)
        .background(
            VStack {
//                Circle().fill(.blue).frame(width: 88, height: 88)
//                    .offset(x: 0, y: circleY)
//                    .scaleEffect(appear[0] ? 1 : 0.1)
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        )
        .onAppear { animate() }
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
        .overlay(content: {
            LoadingView(show: $isLoading)
        })

    }
    
    var form: some View {
        Group {
            
            // User profile picture chooser
            HStack {
                Spacer()
                ZStack {
                    if let userProfilePicData, let image = UIImage(data: userProfilePicData){
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    else {
                        Image("Avatar Default")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .frame(width: 85, height: 85)
                .clipShape(Circle())
                .contentShape(Circle())
                .onTapGesture {
                    showImagePicker.toggle()
                }
                Spacer()
                
            }
            
            
            TextField("Username", text: $username)
                .textContentType(.username)
                .keyboardType(.default)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .customField(icon: "person.fill")
                .overlay(
                    GeometryReader { proxy in
                        let offset = proxy.frame(in: .named("stack")).minY + 22
                        Color.clear.preference(key: CirclePreferenceKey.self, value: offset)
                    }
                        .onPreferenceChange(CirclePreferenceKey.self) { value in
                            circleInitialY = value
                            circleY = value
                        }
                )
                .focused($isUsernameFocused)
                .onChange(of: isUsernameFocused) { isUsernameFocused in
                    if isUsernameFocused {
                        withAnimation {
                            circleY = circleInitialY
                        }
                    }
                }
            
            TextField("", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .placeholder(when: email.isEmpty){
                    Text("Email Address")
                        .foregroundColor(.primary)
                        .blendMode(.overlay)
                }
                .customField(icon: "envelope.open.fill")
                .focused($isEmailFocused)
                .onChange(of: isEmailFocused) { isEmailFocused in
                    if isEmailFocused {
                        withAnimation {
                            circleY = circleInitialY + 70
                        }
                    }
                }
            
            SecureField("", text: $password)
                .textContentType(.password)
                .placeholder(when: password.isEmpty) {
                    Text("Password")
                        .foregroundColor(.primary)
                        .blendMode(.overlay)
                }
                .customField(icon: "key.fill")
                .focused($isPasswordFocused)
                .onChange(of: isPasswordFocused) { isPasswordFocused in
                    if isPasswordFocused {
                        withAnimation {
                            circleY = circleInitialY + 140
                        }
                    }
                }
            
            Button {
                dismissModal()
                signupUser()
            } label: {
                AngularButton(title: "Create Account")
            }
            
            
            Text("By clicking on Sign up, you agree to our **[Terms of Service](https://google.com)** and **Privacy policy**.")
                .font(.footnote)
//                .font(.custom("Raleway", size: 13))
                .foregroundColor(.primary.opacity(0.7))
                .accentColor(.primary.opacity(0.7))
            
            Divider()
            
            Text("Already have an account? **Sign in**")
                .font(.footnote)
//                .font(.custom("Raleway", size: 13))
                .foregroundColor(.primary.opacity(0.7))
                .accentColor(.primary.opacity(0.7))
                .onTapGesture {
                    withAnimation {
                        model.selectedModal = .signIn
                    }
                }
        }
    }
    
    func animate() {
        withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8).delay(0.2)) {
            appear[0] = true
        }
        withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8).delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8).delay(0.6)) {
            appear[2] = true
        }
    }
    
    func signupUser() {
        isLoading = true
        closeKeyboard()
        Task{
            do {
                
                //Creating FireBase account
                try await Auth.auth().createUser(withEmail: email, password: password)
                
                //Upload picture to Firebase
                guard let userUID = Auth.auth().currentUser?.uid else{print("Failed to get user UID")
                    return}
                
                print("User UID: \(userUID)")
                
                
                var storageRef = Storage.storage().reference().child("Profile_Images").child("Avatar Default.jpg")
                //Uploading and downloading PhotoURL.
                if let imageData = userProfilePicData {
                    storageRef = Storage.storage().reference().child("Profile_Images").child(userUID)
                    
                    let _ = try await storageRef.putDataAsync(imageData)
                }
                    
                else {
                    print ("No input image assigned")
                    //return
                }
                
                

                

                
                //Download Photo URL
                let downloadURL = try await storageRef.downloadURL()
                print("Download URL: \(downloadURL)")
                
                //Create a User Firestore Object
                let user = User(username: username, userBio: "", userBioLink: "", school: "", userUID: userUID, userEmail: email)
                
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
        
        func closeKeyboard(){
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    struct SignupView_Previews: PreviewProvider {
        static var previews: some View {
            SignupView(dismissModal: {})
                .environmentObject(Model())
        }
    }
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
