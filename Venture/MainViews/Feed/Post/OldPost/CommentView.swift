//
//  PostHeader.swift
//  Venture
//
//  Created by Lawrence Liu on 1/15/24.
//

import SwiftUI

struct CommentView: View {
    var post: PostModel
    var profile: ProfileModel
    var body: some View {
        //Profile intro
        VStack(alignment: .center){
            HStack(alignment: .center){
                Button {
                } label: {
                    NavigationLink(destination: ProfileView(profile: profile)){
                        Image(profile.profilePicture)
                            .resizable()
                            .frame(width: 36, height: 36)
                            .mask(Circle())
                    }
                    
                }
                
                VStack(alignment: .center){
                    
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
            
        Spacer()
            
            
            HStack(alignment: .bottom){
                
                NavigationLink(destination: ProfileView(profile: profile)){
                    Image(profile.profilePicture)
                        .resizable()
                        .frame(width: 36, height: 36)
                        .mask(Circle())
                        .padding(.leading, 20)
                }
                .accentColor(.primary)
                  
                
                
                Button {
                    
                } label: {
                    Text("_Add a Comment..._")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .opacity(0.3)
                        .font(.footnote)
                        .accentColor(.primary)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .padding(.trailing, 20)
                }


            }

        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    CommentView(post: demoPosts[0], profile: profiles[0])
}
