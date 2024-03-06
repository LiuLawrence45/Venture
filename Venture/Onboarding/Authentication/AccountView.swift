//
//  AccountView.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import SDWebImageSwiftUI

struct AccountView: View {
    @State var isDeleted = false
    @State var isPinned = false
    @Environment(\.dismiss) var dismiss
    @AppStorage("log_status") var logStatus = false
    @AppStorage("isLiteMode") var isLiteMode = true
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    
    
    //Handling the loading for sign out, and possible errors
    @State var isLoading = false
    @State var result: Result<Void, Error>?
    
    //My Profile
    @State private var myProfile: User?
    
    var body: some View {
        Group {
            List {
                profile
                
                menu
                
                Section {
                    Toggle(isOn: $isLiteMode) {
                        Label("Lite Mode", systemImage: isLiteMode ? "tortoise" : "hare")
                    }
                }
                .accentColor(.primary)
                
                links
                
                Button {
                    
                    logOutUser()
                    logStatus = false
                } label: {
                    Text("Sign out")
                }
                .tint(.red)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarItems(trailing: Button { dismiss() } label: { Text("Done").bold() })
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
        .task {
            
            if myProfile != nil {return} //This limits to the first time the tab is called. Keeps it from being called every single time, as .task runs like .onAppear.
            await fetchUserData()
        }
        .refreshable{
            myProfile = nil
            await fetchUserData()
        }
    }
    
    
    func fetchUserData() async {
        guard let userUID = Auth.auth().currentUser?.uid else {return}
        let user = try? await Firestore.firestore().collection("Users").document(userUID).getDocument(as: User.self)
        
        await MainActor.run(body: {
            myProfile = user
        })
    }
    
    func logOutUser(){
        try? Auth.auth().signOut()
        logStatus = false
    }
    
    var profile: some View {
        VStack(spacing: 8) {
            WebImage(url: myProfile?.userProfileURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 72, height: 72)
                .mask(Circle())
                .background(
                    HexagonView()
                        .offset(x: -50, y: -100)
                )
                .background(
                    BlobView()
                        .offset(x: 200, y: 0)
                        .scaleEffect(0.6)
                )
            if let myProfile {
                HStack(spacing: 0){
                    Text(myProfile.firstName ?? "Firstname")
                        .font(.title.weight(.semibold))
                    Text(" ")
                    Text(myProfile.lastName ?? "Lastname")
                        .font(.title.weight(.semibold))
                }

            }

            HStack {
                Image(systemName: "location")
                    .imageScale(.medium)
                Text("Stanford University")
                    .foregroundColor(.primary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    var menu: some View {
        Section {
            NavigationLink(destination: NotReadyView()) {
                Label("Settings", systemImage: "gear")
            }
            NavigationLink (destination: NotReadyView()) {
                Label("Help", systemImage: "questionmark")
            }
        }
        .accentColor(.primary)
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
    }
    
    var links: some View {
        Section {
            if !isDeleted {
                Link(destination: URL(string: "https://apple.com")!) {
                    HStack {
                        Label("Privacy Policy", systemImage: "house")
                        Spacer()
                        Image(systemName: "link")
                            .foregroundColor(.secondary)
                    }
                }
            }


        }
        .accentColor(.primary)
        .listRowSeparator(.hidden)
    }
    
    var pinButton: some View {
        Button { isPinned.toggle() } label: {
            if isPinned {
                Label("Unpin", systemImage: "pin.slash")
            } else {
                Label("Pin", systemImage: "pin")
            }
        }
        .tint(isPinned ? .gray : .yellow)
    }
    
    
    
    //Function for handling sign-outs
    func signOutButtonTapped(){
        Task {
            isLoading = true
//            defer { isLoading = false }
//            
//            do {
//                try await supabase.auth.signOut()
//            }
//            
//            catch {
//                result = .failure(error)
//            }
        }
    }
    
    //Later implemented. But good logic for removing documents, etc...
    func deleteAccount(){
        Task{
            
            do {
                guard let userUID = Auth.auth().currentUser?.uid else{return}
                
                //Delete Image from storage
                let reference = Storage.storage().reference().child("Profile_Images").child(userUID)
                try await reference.delete()
                
                //Delete Firestore User Documents
                try await Firestore.firestore().collection("Users").document(userUID).delete()

                //Delete auth account
                try await Auth.auth().currentUser?.delete()
                logStatus = false
                
            } catch {
                await setError(error)
            }

        }
    }
    
    func setError(_ error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
    
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
