//
//  CommentsView.swift
//  Venture
//
//  Created by Lawrence Liu on 3/2/24.
//

import SwiftUI

struct CommentsView: View {
    
    //Create a comment model to house the information necessary
//    var profile: ProfileModel

    var body: some View {
        var profile = profiles[0]
        
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
    }
}

#Preview {
    CommentsView()
}
