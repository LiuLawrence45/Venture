//
//  PostViewCondensed.swift
//  Venture
//
//  Created by Lawrence Liu on 3/6/24.
//


//This is used in the PersonFeedViews. For searching as well as my own personal profile

import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage
import FirebaseFirestore
import Firebase

struct PostViewCondensed: View {
    
    //Only necessary variable.
    var post: Post
    
    // Callbacks for functions
    var onUpdate: (Post) -> ()
    var onDelete: () -> ()
    
    @AppStorage("user_UID") private var userUID: String = ""

    var body: some View {
        VStack {
            
            //Post heading information (username, time, etc...)
            
            NavigationLink(destination: ItineraryView(post: post)) {
                //All images in the horizontal carousel
                TabView {
                    ForEach(post.imageURLs, id: \.self){ imageURL in
                        ZStack {
                            WebImage(url: imageURL)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width / 2, height: 240)

                                .clipped()
                                
                        }
                        
                    }
                }
                .tabViewStyle(PageTabViewStyle())
            }
            .frame(height: 240)

            
            
            //Post footing information. GUI change soon. Has liking and disliking capabilities.
//            PostFooter(post: post, onUpdate: onUpdate, onDelete: onDelete)
        }
        .overlay(alignment: .topTrailing, content: {
            if post.userUID == userUID {
                Menu {
                    Button("Delete Post", role: .destructive){
                        deletePost(post: post)
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.caption)
                        .foregroundColor(.primary)
                        .padding(8)
                        .contentShape(Rectangle())
                    
                }
            }
        })

        
    }
    
    
    
    //Deleting a Post. Remember, liking and disliking are in PostFooter
    func deletePost(post: Post){
        Task {
            do {
                // If the post has an image reference ID indicating there are images associated with it
                if !post.imageReferenceID.isEmpty {
                    // Assume imageURLs contains the URLs of all images associated with the post
                    let numberOfImages = post.imageURLs.count

                    for index in 0..<numberOfImages {
                        let uniqueImageID = "\(post.imageReferenceID)\(index)"
                        let storageRef = Storage.storage().reference().child("Post_Images").child(uniqueImageID)
                        try await storageRef.delete()
                    }
                }

                // After deleting all images associated with the post, delete the post document itself
                guard let postID = post.id else {return}
                try await Firestore.firestore().collection("Posts").document(postID).delete()
            } catch {
                // Handle errors, such as showing an error message to the user
                print(error.localizedDescription)
            }
        }
    }

        

}


struct PostViewCondensed_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        ContentView()
    }
}
