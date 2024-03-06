//
//  ReusablePostsView.swift
//  Venture
//
//  Created by Lawrence Liu on 3/5/24.
//

import SwiftUI
import Firebase

struct FeedView: View {
    
    var basedOnUID: Bool = false
    var uid: String = ""
    @Binding var posts: [Post]
    @State private var isFetching: Bool = false
    
    @State var contentHasScrolled = false

    var columns = [GridItem(.adaptive(minimum: 300), spacing: 20)]
    

    
    //Pagination settings
    @State private var paginationDoc: QueryDocumentSnapshot?
    
    var body: some View {
        
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                scrollDetection
                LazyVGrid(columns: columns, spacing: 20) {
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
                                .padding(.bottom, 10)
                        }
                    }
                }
                .offset(y: 68)
            }
            .coordinateSpace(name: "scroll")
            
        }
        .overlay(NavigationBar(title: "Weeknd", context: "default", hasScrolled: $contentHasScrolled))
        .task {
            
            //Safe guard to fetch only once
            guard posts.isEmpty else {return}
            isFetching = true
            await fetchPosts()
        }
        .refreshable {
            //Disable refresh for UID based posts
            guard !basedOnUID else {return}
            
            //Scroll to refresh
            isFetching = true
            posts = []
            //Resetting pagination Doc
            paginationDoc = nil
            await fetchPosts()
        }
        
    }
    
    //Scroll detection for top of navBar
    var scrollDetection: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation(.easeInOut) {
                if value < 0 {
                    contentHasScrolled = true
                } else {
                    contentHasScrolled = false
                }
            }
        }
    }
    
    //Accepts multiple views to stitch into a single
    @ViewBuilder
    func Posts()->some View {
        ForEach(posts){ post in
            PostView(post: post) {updatedPost in
                
                //Updating Post in the Array
                if let index = posts.firstIndex(where: { post in
                    post.id == updatedPost.id
                    
                }){
                    posts[index].likedIDs = updatedPost.likedIDs
                    posts[index].dislikedIDs = updatedPost.dislikedIDs
                }
            } onDelete: {
                withAnimation(.easeInOut(duration: 0.25)){
                    posts.removeAll{post == $0}
                }
            }
            .onAppear {
                //When the last post appears, fetch new post (if there)
                
                if post.id == posts.last?.id && paginationDoc != nil {
                    Task{await fetchPosts()}
                }
            }
        }

    }
    
    //Fetching posts
    func fetchPosts() async {
        
        do {
            var query: Query!
            //Implementing Pagination
            if let paginationDoc {
                query = Firestore.firestore().collection("Posts")
                    .order(by: "publishedDate", descending: true)
                    .start(afterDocument: paginationDoc)
                    .limit(to: 20)
            }
            else {
                query = Firestore.firestore().collection("Posts")
                    .order(by: "publishedDate", descending: true)
                    .limit(to: 20)
            }
            
            //New query for UID based Document Search
            if basedOnUID{
                query = query
                    .whereField("userUID", isEqualTo: uid)
            }

            let docs = try await query.getDocuments()
            let fetchedPosts = docs.documents.compactMap { doc -> Post? in
                try? doc.data(as: Post.self)
                
            }
            await MainActor.run(body: {
                posts.append(contentsOf: fetchedPosts)
                paginationDoc = docs.documents.last
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
