//
//  PostHeader.swift
//  Venture
//
//  Created by Lawrence Liu on 1/15/24.
//

import SwiftUI

struct PostHeader: View {
    var post: PostModel
    var body: some View {
        //Profile intro
        HStack(alignment: .center){
            Image(post.profilePicture)
                .resizable()
                .frame(width: 36, height: 36)
                .mask(Circle())
            VStack(alignment: .leading){
                Text(post.username) //replace with structure after
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .fontWeight(.semibold)
                    .frame(alignment: .leading)
                Group {
                    Text("_For you:_") +
                    Text(" ") +
                    Text(String(post.friendsMutuals[0])).bold().italic() +
                    Text(" friends, ") +
                    Text(String(post.friendsMutuals[1])).bold().italic() +
                    Text(" mutuals are down to go.").italic()
                    
                    
                }
                    .font(.caption2)
                    .multilineTextAlignment(.trailing)
                    .frame(alignment: .trailing)
                    .opacity(0.6)

            }
            
            Spacer()
            
            Button {
                
            }
            label: {
                Image(systemName: "ellipsis")
                    .padding(.trailing, 10)
                    .opacity(0.6)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 15)
    }
}

#Preview {
    PostHeader(post: posts[0])
}
