//
//  SigninView.swift
//  Venture
//
//  Created by Lawrence Liu on 3/1/24.
//

import SwiftUI

struct SigninView: View {
    @EnvironmentObject var model: Model
    @State var email = ""
    @State var password = ""
    @State var circleInitialY = CGFloat.zero
    @State var circleY = CGFloat.zero
    @FocusState var isEmailFocused: Bool
    @FocusState var isPasswordFocused: Bool
    @State var appear = [false, false, false]
//    @AppStorage("isLogged") var isLogged = false
    
    
    @State var result: Result<Void, Error>?
    @State var isLoading = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Sign in")
                .font(.largeTitle).bold()
                .blendMode(.overlay)
                .slideFadeIn(show: appear[0], offset: 30)
            
            Text("Discover and document the best for you.")
                .font(.headline)
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
                Circle().fill(.blue).frame(width: 68, height: 68)
                    .offset(x: 0, y: circleY)
                    .scaleEffect(appear[0] ? 1 : 0.1)
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        )
        .modifier(OutlineModifier(cornerRadius: 30))
        .onAppear { animate() }
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
                model.dismissModal.toggle()
                signInButtonTapped()
//                isLogged = true
            } label: {
                AngularButton(title: "Sign in")
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
        }
//        .onOpenURL(perform: { url in
//          Task {
//            do {
//              try await supabase.auth.session(from: url)
//            } catch {
//              self.result = .failure(error)
//            }
//          }
//        })
        
    }
    
    func signInButtonTapped(){
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                try await supabase.auth.signIn(
                    email: email,
                    password: password
                    //redirectTo: URL(string: "io.supabase.user-management://login-callback")
                )
                result = .success(())
            }
            
            catch {
                result = .failure(error)
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
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
            .environmentObject(Model())
    }
}
