//
//  ProfileBlurb.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI

struct ProfileBlurb: View {
    var body: some View {

        VStack() {
            
            HStack (alignment: .center, spacing: 24){
                Spacer()
                Image("Avatar 1")
                    .resizable()
                    .frame(width: 72, height: 72)
                    .mask(Circle())
                    .offset(x: -20)
                
                VStack (alignment: .leading){
                    Text("Tony Nguyen")
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
                            Text("Stanford University")

                        }
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                        HStack {
                            Image(systemName: "hand.point.right")
                            Text("Stanford University")

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
