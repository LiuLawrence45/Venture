//
//  ProfileBlurb.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI

struct ProfileBlurb: View {
    
    var profile: ProfileModel = profiles[1]
    var body: some View {

        VStack() {
            
            HStack (alignment: .center, spacing: 24){
                Spacer()
                Image(profile.profilePicture)
                    .resizable()
                    .frame(width: 72, height: 72)
                    .mask(Circle())
                    .offset(x: -20)
                
                VStack (alignment: .leading){
                    Text("\(profile.firstName) \(profile.lastName)")
                    //Text("Lawrence Liu")
                        .font(.title2.weight(.bold))
                        .padding(.bottom, 10)
                    
                    VStack(alignment: .leading, spacing: 6){
                        HStack {
                            Image(systemName: "person.crop.circle")
                            Text(profile.gender)
                        }
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                        HStack {
                            Image(systemName: "house")
                                .offset(x: -1 )
                            Text(profile.school)
                                .offset(x: -2 )

                        }
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                        HStack {
                            Image(systemName: "hand.point.right")
                            Text(profile.occupation)

                        }
                        .foregroundStyle(.secondary)
                        .font(.caption)
                    }
                }
                Spacer()
                
            

            }
            .padding(.bottom,  20)
            Text(profile.profileDescription)
                .opacity(0.8)
                .font(.footnote)
                .padding(.bottom, 20)
                .italic()
            
            
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
    ProfileBlurb()
}
