//
//  ReusableProfileView.swift
//  Venture
//
//  Created by Lawrence Liu on 3/6/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReusableProfileView: View {
    var user: User
    @State private var fetchedPosts: [Post] = []
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack{
                HStack(spacing: 12) {
                    WebImage(url: user.userProfileURL).placeholder {
                        Image("Avatar Default")
                            .resizable()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                }
                
                VStack(alignment: .leading, spacing: 6){
                    Text(user.username)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text(user.userBio ?? "")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                }
                
                Text("Posts")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .padding(.vertical, 15)
                
                ReusablePostsView(basedOnUID: true, uid: user.userUID ?? "", posts: $fetchedPosts)
            }
        }
        .task {
            print("User UID", user.userUID)
            print("User Name", user.firstName)
        }
    }
}

#Preview {
    ReusableProfileView(user: demoUser)
}
