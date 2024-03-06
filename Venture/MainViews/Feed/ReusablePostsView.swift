//
//  ReusablePostsView.swift
//  Venture
//
//  Created by Lawrence Liu on 3/5/24.
//

import SwiftUI
import Firebase

struct ReusablePostsView: View {
    @Binding var posts: [Post]
    
    @State var isFetching: Bool = true
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                if isFetching {
                    ProgressView()
                        .padding(.top, 30)
                }
                else {
                    
                    //If there are no posts
                    if posts.isEmpty{
                        Text("No posts found")
                            .font(.caption)
                            .foregroundColor(.primary)
                            .opacity(0.7)
                            .padding(.top, 30)
                    }
                    
                    //Display all available posts
                    else {
                        Posts()
                    }
                }
            }
        }
        .task {
            
            //Safe guard to fetch only once
            guard posts.isEmpty else {return}
            
            await fetchPosts()
        }
        .refreshable {
            //Scroll to refresh
            isFetching = true
            posts = []
            await fetchPosts()
        }
        
    }
    
    //Accepts multiple views to stitch into a single
    @ViewBuilder
    func Posts()->some View {
        ForEach(posts){ post in
            Text(post.text)      
        }
    }
    
    //Fetching posts
    func fetchPosts() async {
        
        do {
            var query: Query!
            query = Firestore.firestore().collection("Posts")
                .order(by: "publishedDate", descending: true)
//                .limit(to: 20)
            let docs = try await query.getDocuments()
            let fetchedPosts = docs.documents.compactMap { doc -> Post? in
                try? doc.data(as: Post.self)
                
            }
            await MainActor.run(body: {
                posts = fetchedPosts
                isFetching = false
            })
        }
        
        catch {
            print(error.localizedDescription)
        }
    }
    
    
}

//#Preview {
//    ReusablePostsView()
//}
