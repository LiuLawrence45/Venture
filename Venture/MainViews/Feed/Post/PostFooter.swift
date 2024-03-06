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
                    .font(.title2)
                Spacer()
                Text("$\(post.cost)")
                    .font(.title3)
            }
            .padding(.vertical, 1)
            HStack(spacing: 0){
                Text(post.caption)
                    .foregroundStyle(.secondary)
                    .font(.footnote)
                Spacer()
                PostInteraction()

            }
        }
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
                Image(systemName: post.likedIDs.contains(userUID) ? "bubbles.and.sparkles.fill" : "bubbles.and.sparkles")
            }
            
            Text("\(post.likedIDs.count)")
                .font(.caption)
                .foregroundColor(.primary)
                .opacity(0.7)
            
            Button(action: dislikePost){
                Image(systemName: post.dislikedIDs.contains(userUID) ? "moon.zzz.fill": "moon.zzz")
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
