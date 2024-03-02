//
//  PostHeader.swift
//  Venture
//
//  Created by Lawrence Liu on 1/15/24.
//

import SwiftUI

struct OldPostHeader: View {
    var post: PostModel
    var profile: ProfileModel
    var body: some View {
        //Profile intro
        HStack(alignment: .center){
            Button {
                //NavigationLink(<#T##LocalizedStringKey#>, value: <#T##P?#>)
            } label: {
                NavigationLink(destination: ProfileView(profile: profile)){
                    Image(profile.profilePicture)
                        .resizable()
                        .frame(width: 36, height: 36)
                        .mask(Circle())
                }
                
            }
            
            
            VStack(alignment: .leading){
                
                Button {
                    
                } label:  {
                    NavigationLink(destination: ProfileView(profile: profile)){
                        Text(profile.username) //replace with structure after
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
        .accentColor(.primary)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 15)
    }
}

#Preview {
    OldPostHeader(post: posts[0], profile: profiles[0])
}
