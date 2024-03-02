//
//  ItineraryFooter.swift
//  Venture
//
//  Created by Lawrence Liu on 3/2/24.
//

import SwiftUI

struct ItineraryFooter: View {
    
    var post: PostModel
    @State private var showModal = false
    var body: some View {
        
        VStack(alignment: .leading){
            HStack {
                Text("liulawrence45")
                    .bold()
                    .font(.footnote) 
                
                Spacer()
                Text("#casual, #outing, #SF, #low-cost")
                    .font(.footnote)
                    .italic()
                    .foregroundStyle(.secondary)
            }
            Divider()
                .padding(.vertical, 8)
            
            
            HStack {
                Text("Our Very First ASES Trip!")
                    .font(.footnote)
                Spacer()
                Image(systemName: "cursorarrow.rays")
//                    .font(.system(size: 10))
                Text("4.82")
                    .font(.caption)
            }
            .padding(.vertical, 1)
            HStack(spacing: 0){
                Text("Stanford Area, ")
                    .foregroundStyle(.secondary)
                    .font(.caption)
                Text("4 days")
                    .foregroundStyle(.secondary)
                    .font(.caption)
                Spacer()
                Text("$280 total")
                    .font(.caption)
            }
        }
        .padding(.horizontal, 8)
        
    }
}


#Preview {
    ItineraryFooter(post: posts[0])
}
