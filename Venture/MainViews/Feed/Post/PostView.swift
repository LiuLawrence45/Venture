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
    @State private var fetchedUsers: [User] = []
    
    // Callbacks for functions
    var onUpdate: (Post) -> ()
    var onDelete: () -> ()
    
    @AppStorage("user_UID") private var userUID: String = ""

    var body: some View {
        VStack {
            
            //Post heading information (username, time, etc...)
            if !fetchedUsers.isEmpty {
                PostHeader(post: post, user: fetchedUsers[0])
            }
            
            
            NavigationLink(destination: ItineraryView(post: post)) {
                
                //Alternate view of what Katie said: ZStack
                
                ZStack(alignment: .center) {
                    ForEach(Array(post.imageURLs.enumerated().prefix(3)), id: \.offset){ index, imageURL in
                            WebImage(url: imageURL)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width - 16, height: 240)
                                .clipped()
                                .shadow(radius: 4)
                                .offset(x: CGFloat(index * -6), y: CGFloat(index * 10))

                        }
                }
                
                
                //All images in the horizontal carousel
                    
//                TabView {
//                    ForEach(post.imageURLs, id: \.self){ imageURL in
//                        ZStack {
//                            WebImage(url: imageURL)
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: UIScreen.main.bounds.width - 16, height: 480)
//
//                                .clipped()
//                                
//                        }
//                        
//                    }
//                }
//                .tabViewStyle(PageTabViewStyle())
                
                
            }
            .frame(height: 320)
            .padding(.horizontal, 16) //Change back to 8 if we are doing normal carousel.
            .overlay(
                PostFooter(post: post, onUpdate: onUpdate, onDelete: onDelete),
                alignment: .bottom
            )

            
            
            //Post footing information. GUI change soon. Has liking and disliking capabilities.
//            PostFooter(post: post, onUpdate: onUpdate, onDelete: onDelete)
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
    
    
    //Matching by username. Is there any way to match by userID? Yes. Just don't be stupid. use userUID. The below code is garbage. Need to change.
    func findUser() async {
        do {
            
            let snapshot = try await Firestore.firestore().collection("Users").whereField("username", isEqualTo: post.userName).getDocuments()
            
            // Map documents to users
            let users = try snapshot.documents.compactMap { doc -> User? in
                try doc.data(as: User.self)
            }
            
            await MainActor.run {
                fetchedUsers = users
            }
        }
        
        catch {
            print(error.localizedDescription)
        }

        
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
