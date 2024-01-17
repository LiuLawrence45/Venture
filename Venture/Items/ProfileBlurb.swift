//
//  ProfileBlurb.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI

struct ProfileBlurb: View {
    
    //var profile: ProfileModel = profiles[0]
    var body: some View {

        VStack() {
            
            HStack (alignment: .center, spacing: 24){
                Spacer()
                Image("04B0D33D-83BB-4E23-BE56-50EFA4FB1B7C")
                    .resizable()
                    .frame(width: 72, height: 72)
                    .mask(Circle())
                    .offset(x: -20)
                
                VStack (alignment: .leading){
                    Text("Lawrence Liu")
                        .font(.title2.weight(.bold))
                        .padding(.bottom)
                    
                    VStack(alignment: .leading, spacing: 6){
                        HStack {
                            Image(systemName: "person.crop.circle")
                            Text("he/him")
                        }
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                        HStack {
                            Image(systemName: "house")
                                .offset(x: -1 )
                            Text("Stanford University")
                                .offset(x: -2 )

                        }
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                        HStack {
                            Image(systemName: "hand.point.right")
                            Text("CompBio @ SMC")

                        }
                        .foregroundStyle(.secondary)
                        .font(.caption)
                    }
                }
                Spacer()
                
            

            }
            .padding(.bottom,  20)
            Text("_Lover all of things adventure-wise._")
                .opacity(0.8)
                .font(.footnote)
                .padding(.bottom, 20)
            
            
            HStack(spacing: 40){
                Text("6 Posts")
                    .fontWeight(.semibold)
                Text ("170 friends")
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
