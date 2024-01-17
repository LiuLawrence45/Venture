//
//  PostHeader.swift
//  Venture
//
//  Created by Lawrence Liu on 1/15/24.
//

import SwiftUI

struct CommentView: View {
    var post: PostModel
    var body: some View {
        //Profile intro
        HStack(alignment: .center){
            Button {
                //NavigationLink(<#T##LocalizedStringKey#>, value: <#T##P?#>)
            } label: {
                NavigationLink(destination: ProfileView()){
                    Image(post.profilePicture)
                        .resizable()
                        .frame(width: 36, height: 36)
                        .mask(Circle())
                }
                
            }
            
            VStack(alignment: .leading){
                
                Button {
                    
                } label:  {
                    NavigationLink(destination: ProfileView()){
                        Text(post.username) //replace with structure after
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.semibold)
                            .frame(alignment: .leading)
                    }
                    
                }
                .accentColor(.primary)
                
                Group {
                    
                    Text("This looks so fun!")
                    
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
            Image(systemName: "heart")
                .padding(.trailing, 10)
                .opacity(0.4)
                .foregroundColor(.gray)
        }
        .accentColor(.primary)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 15)
    }
}

#Preview {
    CommentView(post: posts[0])
}
