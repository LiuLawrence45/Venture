//
//  SignupView.swift
//  SignupView
//
//  Created by Meng To on 2021-07-27.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var model: Model
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var circleInitialY = CGFloat.zero
    @State var circleY = CGFloat.zero
    @FocusState var isEmailFocused: Bool
    @FocusState var isPasswordFocused: Bool
    @FocusState var isConfirmPasswordFocused: Bool
    @State var appear = [false, false, false]
    var dismissModal: () -> Void
    @AppStorage("isLogged") var isLogged = false
    
    @State var result: Result<Void, Error>?
    @State var isLoading = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Sign up")
                .font(.largeTitle).bold()
                .blendMode(.overlay)
                .slideFadeIn(show: appear[0], offset: 30)
            
            Text("Discover and document the best for you.")
                .font(.headline)
                .foregroundColor(.primary.opacity(0.7))
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
                Circle().fill(.blue).frame(width: 88, height: 88)
                    .offset(x: 0, y: circleY)
                    .scaleEffect(appear[0] ? 1 : 0.1)
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        )
        .onAppear { animate() }
    }
    
    var form: some View {
        Group {
            TextField("", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .placeholder(when: email.isEmpty) {
                    Text("Email address")
                        .foregroundColor(.primary)
                        .blendMode(.overlay)
                }
                .customField(icon: "envelope.open.fill")
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
                .focused($isEmailFocused)
                .onChange(of: isEmailFocused) { isEmailFocused in
                    if isEmailFocused {
                        withAnimation {
                            circleY = circleInitialY
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
                            circleY = circleInitialY + 70
                        }
                    }
                }
            
            SecureField("", text: $confirmPassword)
                .textContentType(.password)
                .placeholder(when: confirmPassword.isEmpty) {
                    Text("Confirm Password")
                        .foregroundColor(.primary)
                        .blendMode(.overlay)
                }
                .customField(icon: "key.fill")
                .focused($isPasswordFocused)
                .onChange(of: isPasswordFocused) { isPasswordFocused in
                    if isPasswordFocused {
                        withAnimation {
                            circleY = circleInitialY + 70
                        }
                    }
                }
            
            Button {
                dismissModal()
                signUpButtonTapped()
            } label: {
                AngularButton(title: "Create Account")
            }
            
            if let result  {
                Section {
                    switch result {
                    case .success:
                        Text("Success")
                    case .failure(let error):
                        Text(error.localizedDescription).foregroundStyle(.red)
                    }

                    
                }
            }
            
            
            Text("By clicking on Sign up, you agree to our **[Terms of service](https://designcode.io)** and **Privacy policy**.")
                .font(.footnote)
                .foregroundColor(.primary.opacity(0.7))
                .accentColor(.primary.opacity(0.7))
            
            Divider()
            
            Text("Already have an account? **Sign in**")
                .font(.footnote)
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
    
    func signUpButtonTapped(){
        Task {
            isLoading = true
            defer { isLoading = false }
            
            guard password == confirmPassword else {
                result = .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Passwords do not match."]))
                return
            }
            
            do {
                try await supabase.auth.signUp(
                    email: email,
                    password: password
                )
                result = .success(())
                try await supabase.auth.signIn(
                    email: email,
                    password: password
                )
                result = .success(())
            } catch {
                result = .failure(error)
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(dismissModal: {})
            .environmentObject(Model())
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
