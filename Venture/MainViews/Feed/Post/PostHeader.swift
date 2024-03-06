//
//  PostHeader.swift
//  Venture
//
//  Created by Lawrence Liu on 1/15/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostHeader: View {
    var post: Post
    var body: some View {
        //Profile intro
        HStack(alignment: .center){
            Button {
            } label: {
                NavigationLink(destination: EmptyView()){
                    WebImage(url: post.userProfileURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 36, height: 36)
                        .mask(Circle())
                }
                
            }
            
            
            VStack(alignment: .leading){
                
                Button {
                    
                } label:  {
                    NavigationLink(destination: EmptyView()){
                        Text(post.userName) //replace with structure after
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.semibold)
                            .frame(alignment: .leading)
                    }
                    
                }
                .accentColor(.primary)
                
                Group {
                    Text("_For you:_") +
                    Text(" ") +
                    Text("3").bold().italic() +
                    Text(" friends, ") +
                    Text("4").bold().italic() +
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
        .accentColor(.primary)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 8)
    }
}

//#Preview {
//    PostHeader(post: demoPosts[0], profile: profiles[0])
//}
