//
//  PostFooter.swift
//  Venture
//
//  Created by Lawrence Liu on 1/15/24.
//

import SwiftUI

struct PostFooter: View {
    var post: PostModel
    var body: some View {
        
        Group {
            Text("View all ") +
            Text(String(post.numberOfComments)) +
            Text(" comments...")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 2)
        .opacity(0.5)
        .font(.footnote)
    }
}

#Preview {
    PostFooter(post: posts[0])
}
