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
                Image("Avatar Default")
                    .resizable()
                    .frame(width: 72, height: 72)
                    .mask(Circle())
                    .offset(x: -20)
                
                VStack (alignment: .leading, spacing: 12){
                    Text("Tony Nguyen")
                        .font(.title2.weight(.bold))
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
                    
                

                }
                Spacer()
                
            

            }
            .padding(.bottom,  20)
            Text("Someone _please_ go to Berkeley with me to a football game. ")
                .opacity(0.8)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
    }
}

    

#Preview {
    ProfileBlurb()
}
