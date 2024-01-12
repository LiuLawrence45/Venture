//
//  FeaturedPost.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

/*
 This "featured post" is intended to be a condensed formatting of an original post, to be displayed in discovery, etc... 
 */

import SwiftUI

struct FeaturedPost: View {
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Spacer()
            
            //Image(course.logo)
            Image("Avatar Default")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 26.0, height: 26.0)
                .cornerRadius(10)
                .padding(9)
                .background(Color(UIColor.systemBackground).opacity(0.1), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .strokeStyle(cornerRadius: 16)
            //Text(course.title)
            Text("Post Title")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .lineLimit(1)
                .dynamicTypeSize(.large)
            //Text(course.subtitle.uppercased())
            Text("Post Subtitle") // can replace this with
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            //Text(course.text)
            Text("Post Text")
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .lineLimit(sizeCategory > .large ? 1 : 2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary)
        }
        .padding(.all, 20.0)
        .padding(.vertical, 20)
        .frame(height: 350.0)
        .background(.ultraThinMaterial)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
//        .cornerRadius(30.0)
//        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle()
        .padding(.horizontal, 20)
    }
}

struct FeaturedPost_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedPost()
            .environment(\.sizeCategory, .extraExtraLarge)
    }
}
