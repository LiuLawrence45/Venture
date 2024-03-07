//
//  PostFooter.swift
//  Venture
//
//  Created by Lawrence Liu on 1/15/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import Firebase

struct PostFooter: View {
    
    var post: Post
    var onUpdate: (Post) -> ()
    var onDelete: () -> ()
    @State private var showModal = false
    
    //View Properties
    @AppStorage("user_UID") private var userUID: String = ""
    @State private var docListener: ListenerRegistration?
 
    var body: some View {
        
        VStack(alignment: .leading){
            HStack {
                Text(post.location)
                    .bold()
                    .font(.custom("Michroma-Regular", size: 18))
                    //.font(.title2)

                Spacer()
                if post.cost != "" {
                    Text("$\(post.cost)")
                        //.font(.title3)
                        .font(.custom("Michroma-Regular", size: 18))
                }
            }
            .padding(.vertical, 1)
            HStack(spacing: 0){
                Text(post.caption)
                    .foregroundStyle(.secondary)
                    .font(.footnote)
                    .font(.custom("Michroma-Regular", size: 12)) //Font will and can be changed.
                Spacer()
                PostInteraction()

            }
        }
        .padding(.horizontal, 8)
        
        //Remove this background if we want to get rid of the gray.
        .background(Color(red: 29.0/255.0, green: 29.0/255.0, blue: 29.0/255.0))
        .opacity(0.93)
        .padding(.horizontal, 8)
        .onAppear{
            
            //Adding only once...
            if docListener == nil {
                guard let postID = post.id else {return}
                docListener = Firestore.firestore().collection("Posts").document(postID).addSnapshotListener({ snapshot, error in
                    
                    if let snapshot{
                        if snapshot.exists {
                            
                            //Document updated, fetching updated document
                            if let updatedPost = try? snapshot.data(as: Post.self){
                                onUpdate(updatedPost)
                            }
                        }
                        else {
                           onDelete()
                        }
                    }
                })
            }
        }
        .onDisappear {
            //Removes the listener (stopping unwanted live updates when not on the screen)
            
            if let docListener{
                docListener.remove()
            }
        }


    }
    
    
    //Like, dislike interaction. Probably implement this in the actual itinerary section.
    @ViewBuilder
    func PostInteraction() -> some View {
        HStack(spacing: 6) {
            Button(action: likePost) {
                Image(systemName: post.likedIDs.contains(userUID) ? "hand.thumbsup.circle.fill" : "hand.thumbsup.circle")
            }
            
            Text("\(post.likedIDs.count)")
                .font(.caption)
                .foregroundColor(.primary)
                .opacity(0.7)
            
            Button(action: dislikePost){
                Image(systemName: post.dislikedIDs.contains(userUID) ? "hand.thumbsdown.circle.fill": "hand.thumbsdown.circle")
            }
            
            Text("\(post.dislikedIDs.count)")
                .font(.caption)
                .foregroundColor(.primary)
                .opacity(0.7)
        }
        .padding(.vertical, 8)
        .foregroundColor(.primary)
    }
    
    
    //Liking post function
    func likePost(){
        Task {
            guard let postID = post.id else {return}
            if post.likedIDs.contains(userUID) {
                //Removing the User ID from the array
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "likedIDs": FieldValue.arrayRemove([userUID])
                ])
            }
            else {
                //Adding user ID to liked array and removing our ID from disliked array (if added before)
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "likedIDs": FieldValue.arrayUnion([userUID]),
                    "dislikedIDs": FieldValue.arrayRemove([userUID])
                ])
            }
        }
    }
    
    //Dislike a post!
    func dislikePost(){
        Task {
            guard let postID = post.id else {return}
            if post.dislikedIDs.contains(userUID) {
                //Removing the User ID from the array
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "dislikedIDs": FieldValue.arrayRemove([userUID])
                ])
            }
            else {
                //Adding user ID to liked array and removing our ID from disliked array (if added before)
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "likedIDs": FieldValue.arrayRemove([userUID]),
                    "dislikedIDs": FieldValue.arrayUnion([userUID])
                ])
            }
        }
    }
    
}

//Can use later if want to implement a Modal View
//struct ModalView: View {
//    var body: some View {
//        VStack {
//            CommentView(post: demoPosts[0], profile: profiles[0])
//        }
//        .padding(.top, 20)
//        .padding(.bottom, 0) 
//
//    } 
//}
//
#Preview {
    //This is outdated. Do not use demoPosts[0]
    ContentView()
}
