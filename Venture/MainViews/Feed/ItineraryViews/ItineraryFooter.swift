//
//  ItineraryFooter.swift
//  Venture
//
//  Created by Lawrence Liu on 3/2/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ItineraryFooter: View {
    
    //Fetching user from Post.
    @State var fetchedUser: User = demoUser
    var post: Post
    
    @State private var showModal = false
    var body: some View {
        
        VStack(alignment: .leading){
            HStack {
                
                Button {
                } label: {
                    NavigationLink(destination: OthersProfileView(myProfile: fetchedUser)){
                        Text(post.userName)
                            .foregroundStyle(.secondary)
                            .font(.footnote)
                    }
                    
                }

                
                Spacer()
                Text("Central Location: \(post.location)")
                    .font(.footnote)
            }
            .task {
                fetchUser()
            }
            
            Divider()
                .padding(.vertical, 8)
            
            //Add Title
            HStack(spacing: 16){
                Text("🌱")
                Text(post.title)
            }
            .fontWeight(.bold)

            
            //Quick Caption (postText)
            HStack(spacing: 16) {
                Text("🎤")
                Text(post.caption)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }

        }
        .padding(.horizontal, 8)
        .padding(.vertical, 0)
        

        
        Divider()
        
        HStack(spacing: 0) {
            Text("Trip Details")
                .fontWeight(.bold)
                .font(.body)
                
        }

        VStack(alignment: .leading, spacing: 8){
            //Add Costs; only allows in number input
            
            if post.cost != "" {
                HStack(spacing: 16){
                    Text("💸")
                    Text("Cost per person: \(post.cost)")
                    Spacer()
                }
                .font(.footnote)
            }

            //Car needed?
            
            HStack(spacing: 16) {
                Text("🚗")
                if (post.carNeeded == true){
                    Text("Car is needed.")
                }
                else {
                    Text("Car is not needed!")
                }
                
            }
            .font(.footnote)

            //How many people?
            if post.people != "" {
                HStack(spacing: 16){
                    Text("🙋‍♀️")
                    Text("\(post.people) people went on this trip")
                }
                .font(.footnote)
            }

            Divider()
                .padding(.vertical, 8)

        }

        
        
    }
    
    
    func fetchUser() {
        let docRef = Firestore.firestore().collection("Users").document(post.userUID)
        
        docRef.getDocument{ (document, error) in
            let result = Result {
                try document?.data(as: User.self)
            }
            
            switch result {
            case .success(let user):
                if let user = user {
                    fetchedUser = user
                }
                else {
                    print("Document does not exist")
                }
            
            case .failure(let error):
                print("Error decoding user: \(error.localizedDescription)")
            }
            
        }
    }
}


//#Preview {
//    ItineraryFooter(post: demoPosts[0])
//}
