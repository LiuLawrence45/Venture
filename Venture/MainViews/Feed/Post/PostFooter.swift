//
//  PostFooter.swift
//  Venture
//
//  Created by Lawrence Liu on 1/15/24.
//

import SwiftUI

struct PostFooter: View {
    
    var post: Post
    @State private var showModal = false
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
                    .font(.caption)
                Spacer()
                PostInteraction()

            }
        }
//        .background(.ultraThickMaterial)
        .padding(.horizontal, 8)


    }
    
    
    //Like, dislike interaction. Probably implement this in the actual itinerary section.
    @ViewBuilder
    func PostInteraction() -> some View {
        HStack(spacing: 6) {
            Button {
                
            } label: {
                Image(systemName: post.likedIDs.contains("") ? "hand.thumbsup.fill" : "hand.thumbsup")
            }
            
            Text("\(post.likedIDs.count)")
                .font(.caption)
                .foregroundColor(.primary)
                .opacity(0.7)
            
            Button {
                
            } label: {
                Image(systemName: post.dislikedIDs.contains("") ? "hand.thumbsdown.fill": "hand.thumbsdown")
            }
            
            Text("\(post.dislikedIDs.count)")
                .font(.caption)
                .foregroundColor(.primary)
                .opacity(0.7)
        }
        .padding(.vertical, 8)
        .foregroundColor(.primary)
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
