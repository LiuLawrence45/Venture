//
//  SigninView.swift
//  Venture
//
//  Created by Lawrence Liu on 3/1/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct SigninView: View {
    @EnvironmentObject var model: Model
    @State var email = ""
    @State var password = ""
    @State var circleInitialY = CGFloat.zero
    @State var circleY = CGFloat.zero
    @FocusState var isEmailFocused: Bool
    @FocusState var isPasswordFocused: Bool
    @State var appear = [false, false, false]
    
    //Loading variables
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    
    //User Defaults
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Sign in")
//                .font(.largeTitle).bold()
                .font(.custom("Michroma-Regular", size: 32))
                .slideFadeIn(show: appear[0], offset: 30)
            
            Text("Every day is the Weeknd.")
//                .font(.headline)
                .font(.custom("Michroma-Regular", size: 18))
                .foregroundStyle(.secondary)
                .slideFadeIn(show: appear[1], offset: 20)
            
            form.slideFadeIn(show: appear[2], offset: 10)
        }
        .coordinateSpace(name: "stack")
        .padding(20)
        .padding(.vertical, 20)
        .background(.ultraThinMaterial)
        .backgroundColor(opacity: 0.4)
        .cornerRadius(30)
        .background(
            VStack {
//                Circle().fill(.blue).frame(width: 68, height: 68)
//                    .offset(x: 0, y: circleY)
//                    .scaleEffect(appear[0] ? 1 : 0.1)
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        )
        .modifier(OutlineModifier(cornerRadius: 30))
        .onAppear { animate() }
        
        //Display alert for errors, etc...
        .alert(errorMessage, isPresented: $showError, actions: {})
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
    }
    
    var form: some View {
        Group {
            TextField("Email address", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .customField(icon: "envelope.open.fill")
                .overlay(
                    GeometryReader { proxy in
                        let offset = proxy.frame(in: .named("stack")).minY + 32
                        Color.clear.preference(key: CirclePreferenceKey.self, value: offset)
                    }
                    .onPreferenceChange(CirclePreferenceKey.self) { value in
                        circleInitialY = value
                        circleY = value
                    }
                )
                .focused($isEmailFocused)
                .onChange(of: isEmailFocused) { isEmailFocused in
                    if isEmailFocused {
                        withAnimation {
                            circleY = circleInitialY
                        }
                    }
                }
            
            SecureField("Password", text: $password)
                .textContentType(.password)
                .customField(icon: "key.fill")
                .focused($isPasswordFocused)
                .onChange(of: isPasswordFocused, perform: { isPasswordFocused in
                    if isPasswordFocused {
                        withAnimation {
                            circleY = circleInitialY + 70
                        }
                    }
                })
            
            Button {
                loginUser()
                model.dismissModal.toggle()
            } label: {
                AngularButton(title: "Sign in")
            }
            
            Divider()
            
            Text("No account yet? **Sign up**")
                .font(.footnote)
                .foregroundColor(.primary.opacity(0.7))
                .accentColor(.primary.opacity(0.7))
                .onTapGesture {
                    withAnimation {
                        model.selectedModal = .signUp
                    }
                }
            
            
            HStack(spacing: 0){
                Text("Need help getting in? ")
                    .font(.footnote)
                    .foregroundColor(.primary.opacity(0.7))
                    .accentColor(.primary.opacity(0.7))
                Button {
                    resetPassword()
                } label: {
                    
                    Text("**Reset Password**")
                        .font(.footnote)
                        .foregroundColor(.primary.opacity(0.7))
                        .accentColor(.primary.opacity(0.7))
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
    
    func loginUser() {
        isLoading = true
        closeKeyboard()
        Task{
            do {
                try await Auth.auth().signIn(withEmail: email, password: password)
                print("User found")
//                logStatus = true
                try await fetchUser()
            }
            
            catch {
                await setError(error)
            }
        }
    }
    
    func fetchUser() async throws {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let user = try await Firestore.firestore().collection("Users").document(userID).getDocument(as: User.self)
        
        //UI Updating run on main thread
        await MainActor.run(body: {
            
            //Setting user defaults data and changing app's auth status.
            userUID = userID
            userNameStored = user.username
            profileURL = user.userProfileURL
            logStatus = true
        })
    }
    
    func setError(_ error: Error) async {
        await MainActor.run(body:  {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
    
    func resetPassword(){
        Task{
            do {
                try await Auth.auth().sendPasswordReset(withEmail: email)
                print("Link sent")
            }
            
            catch {
                await setError(error)
            }
        }
    }
    
    func closeKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
            .environmentObject(Model())
    }
}
