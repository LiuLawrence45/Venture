//
//  ReusablePostsView.swift
//  Venture
//
//  Created by Lawrence Liu on 3/5/24.
//

import SwiftUI
import Firebase

struct ReusablePostsView: View {
    
    @State var contentHasScrolled = false
    @Binding var posts: [Post]
    var columns = [GridItem(.adaptive(minimum: 300), spacing: 20)]
    
    @State var isFetching: Bool = false
    
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
            //Scroll to refresh
            isFetching = true
            posts = []
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
                
            } onDelete: {
                
            }
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
