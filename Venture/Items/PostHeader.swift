//
//  PostHeader.swift
//  Venture
//
//  Created by Lawrence Liu on 1/15/24.
//

import SwiftUI

struct PostHeader: View {
    var body: some View {
        //Profile intro
        HStack(alignment: .center){
            Image("Avatar 2")
                .resizable()
                .frame(width: 36, height: 36)
                .mask(Circle())
            VStack(alignment: .leading){
                Text("liu.lawrence45") //replace with structure after
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .fontWeight(.semibold)
                    .frame(alignment: .leading)
                Text("_For you: **5** friends and **6** mutuals are down to go..._")
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
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 15)
    }
}

#Preview {
    PostHeader()
}
