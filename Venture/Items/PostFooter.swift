//
//  PostFooter.swift
//  Venture
//
//  Created by Lawrence Liu on 1/15/24.
//

import SwiftUI

struct PostFooter: View {
    var body: some View {
        Text("View all 2 comments...")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.vertical, 2)
                .opacity(0.5)
                .font(.footnote)
    }
}

#Preview {
    PostFooter()
}
