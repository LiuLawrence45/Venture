//
//  Post.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//


/*
 Default post formatting for feed display.
 */

import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage
import FirebaseFirestore
import Firebase

struct PostView: View {
    
    //Only necessary variable.
    var post: Post
    
    // Callbacks for functions
    var onUpdate: (Post) -> ()
    var onDelete: () -> ()
    
    @AppStorage("user_UID") private var userUID: String = ""

    var body: some View {
        VStack {
            
            //Post heading information (username, time, etc...)
            PostHeader(post: post)
            
            
            NavigationLink(destination: ItineraryView(post: post)) {
                //All images in the horizontal carousel
                TabView {
                    ForEach(post.imageURLs, id: \.self){ imageURL in
                        ZStack {
                            WebImage(url: imageURL)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width - 16, height: 480)

                                .clipped()
                                
                        }
                        
                    }
                }
                .tabViewStyle(PageTabViewStyle())
            }
            .frame(height: 480)
            .padding(.horizontal, 8)

            
            
            //Post footing information. GUI change soon. Has liking and disliking capabilities.
            PostFooter(post: post, onUpdate: onUpdate, onDelete: onDelete)
        }
        .overlay(alignment: .topTrailing, content: {
            if post.userUID == userUID {
                Menu {
                    Button("Delete Post", role: .destructive, action: deletePost)
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.caption)
                        .rotationEffect(.init(degrees: -90))
                        .foregroundColor(.primary)
                        .padding(8)
                        .contentShape(Rectangle())
                    
                }
            }
        })

        
    }
    
    
    
    //Deleting a Post. Remember, liking and disliking are in PostFooter
    func deletePost(){
        Task {
            
            do {
                if post.imageReferenceID != "" {
                    try await Storage.storage().reference().child("Post_Images").child(post.imageReferenceID).delete()
                }
                
                guard let postID = post.id else {return}
                try await Firestore.firestore().collection("Posts").document(postID).delete()
            }
            
            catch {
                print(error.localizedDescription)
            }

        }
    }

        

}


struct PostView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        
//        Post(namespace: namespace, show: .constant(true))
//        PostView(post: <#Post#>, onUpdate: <#(Post) -> ()#>, onDelete: <#() -> ()#>)
        ContentView()
    }
}
