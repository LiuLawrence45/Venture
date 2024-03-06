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
                Text("Our Very First ASES Trip!")
                    .bold()
                    .font(.footnote)
                Spacer()
                Image(systemName: "cursorarrow.rays")
//                    .font(.system(size: 10))
                Text("4.82")
                    .font(.caption)
            }
            .padding(.vertical, 1)
            HStack(spacing: 0){
                Text("Stanford Area, ")
                    .foregroundStyle(.secondary)
                    .font(.caption)
                Text("4 days")
                    .foregroundStyle(.secondary)
                    .font(.caption)
                Spacer()
                Text("$280 total")
                    .font(.caption)
            }
        }
        .padding(.horizontal, 8)

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
