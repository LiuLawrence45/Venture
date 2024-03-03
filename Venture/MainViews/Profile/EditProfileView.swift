//
//  EditProfileView.swift
//  Venture
//
//  Created by Lawrence Liu on 3/2/24.
//

import SwiftUI


struct EditProfileView: View {

    @State var username = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var gender = ""
    @State var school = ""
    @State var occupation = ""
    @State var profileDescription = ""
    
    @State var isLoading = false
    
    var body: some View {
        
        Text("Hello")
//        NavigationStack {
//            Form {
//                Section {
//                    TextField("Username", text: $username)
//                        .textContentType(.username)
//                        .textInputAutocapitalization(.never)
//                    TextField("First Name", text: $firstName)
//                        .textContentType(.name)
//                    TextField("Last Name", text: $lastName)
//                        .textContentType(.name)
//                    TextField("Gender", text: $gender)
//                        .textContentType(.name)
//                    TextField("School", text: $school)
//                        .textContentType(.name)
//                    TextField("Occupation", text: $occupation)
//                        .textContentType(.name)
//                    TextField("Profile Description", text: $profileDescription)
//                        .textContentType(.username)
//                        .textInputAutocapitalization(.never)
//                }
//                
//                Section {
//                    Button("Update profile") {
//                        updateProfileButtonTapped()
//                    }
//                    .bold()
//                    
//                    if isLoading {
//                        ProgressView()
//                    }
//                }
//            }
//            .navigationTitle("Profile")
//        }
//        .task {
//            await getInitialProfile()
//        }
//    }
//    
//    func getInitialProfile() async {
//        do {
//            let currentUser = try await supabase.auth.session.user
//            
//            let profile: Profile = try await supabase.database
//                .from("profiles")
//                .select()
//                .eq("id", value: currentUser.id)
//                .single()
//                .execute()
//                .value
//            
//            self.username = profile.username ?? ""
//            self.firstName = profile.firstName ?? ""
//            self.lastName = profile.lastName ?? ""
//            self.gender = profile.gender ?? ""
//            self.school = profile.school ?? ""
//            self.occupation = profile.occupation ?? ""
//            self.profileDescription = profile.profileDescription ?? ""
//            
//        } catch {
//            debugPrint(error)
//        }
//    }
//    
//    func updateProfileButtonTapped() {
//        Task {
//            isLoading = true
//            defer { isLoading = false }
//            do {
//                let currentUser = try await supabase.auth.session.user
//                
//                try await supabase.database
//                    .from("profiles")
//                    .update(
//                        UpdateProfileParams(
//                            username: username,
//                            firstName: firstName,
//                            lastName: lastName,
//                            gender: gender,
//                            school: school,
//                            occupation: occupation,
//                            profileDescription: profileDescription
//                        )
//                    )
//                    .eq("id", value: currentUser.id)
//                    .execute()
//            } catch {
//                debugPrint(error)
//            }
//        }
    }
}
#Preview {
    EditProfileView()
}
