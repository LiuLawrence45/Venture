//
//  ProfileBlurb.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileBlurb: View {
    
    var profile: ProfileModel = profiles[1]
    var user: User
    var body: some View {

        VStack() {
            
            HStack (alignment: .center, spacing: 24){
                Spacer()
                
                WebImage(url: user.userProfileURL).placeholder{
                    Image("NullProfile")
                }
                .resizable()
                .frame(width: 72, height: 72)
                .mask(Circle())
                .offset(x: -20)
//                Image(profile.profilePicture)
//                    .resizable()
//                    .frame(width: 72, height: 72)
//                    .mask(Circle())
//                    .offset(x: -20)
                
                VStack (alignment: .leading){
                    HStack(spacing: 0){
                        Text(user.firstName ?? "")
                        Text(" ")
                        Text(user.lastName ?? "")
                    }
                    .font(.title2.weight(.bold))
                    .padding(.bottom, 10)
                    
                    //Text("\(user.firstName) \(user.lastName)")

                    
                    VStack(alignment: .leading, spacing: 6){
                        HStack{
                            Image(systemName: "person.crop.circle")
//                            Text(profile.gender)
                            Text(user.username)
                        }
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                        HStack {
                            Image(systemName: "house")
                                .offset(x: -1 )
                            Text(user.school ?? "No school entered")
                                .offset(x: -2 )

                        }
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                        
                        if let bioLink = URL(string: user.userBioLink ?? "") {
                            HStack {
                                Image(systemName: "hand.point.right")
    //                            Text(profile.occupation)
                                Link(user.userBioLink!, destination: bioLink)

                            }
                            .foregroundStyle(.secondary)
                            .font(.caption)
                            .tint(.blue)
                            .lineLimit(1)
                        }

                    }
                }
                Spacer()
                
            

            }
            .padding(.bottom,  20)
            Text(user.userBio ?? "")
                .opacity(0.8)
                .font(.footnote)
                .padding(.bottom, 20)
                .italic()
                .lineLimit(2)
            
            
            HStack(spacing: 40){
                Text("\(profile.posts.count) Posts")
                    .fontWeight(.semibold)
                Text ("\(profile.numFriends) friends")
                    .fontWeight(.semibold)
            }
        }
        .frame(alignment: .center)
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
    }
}

    

#Preview {
    ProfileBlurb(user: demoUser)
}
