//
//  Post.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//


/*
 Default post formatting for feed display.
 */

import SwiftUI

struct Post: View {
    var namespace: Namespace.ID
    var post: PostModel = posts[0]
    @Binding var show: Bool
    var body: some View {
        VStack {
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 12) {
                    Group {
                        Text(post.title)
                            .font(.subheadline.weight(.bold))
                            .matchedGeometryEffect(id: "title\(post.id)", in: namespace)
                            .opacity(0.5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Text(post.caption ?? "")
                            .font(.footnote)
                            .opacity(0.5)
                            .matchedGeometryEffect(id: "text\(post.id)", in: namespace)
                    }
                    .offset(y: -20)

                }
                .padding(20)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .blur(radius: 30)
                        .matchedGeometryEffect(id: "blur\(post.id)", in: namespace)
                )
            }
            .foregroundStyle(.white)
            .background(
                //Image("Background 6")
                
                TabView {
                    ForEach(post.images, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width)
                            .clipped()
                        
                    }

                }.tabViewStyle(PageTabViewStyle())
                

            )
            .mask(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .matchedGeometryEffect(id: "mask\(post.id)", in: namespace)
            )
        .frame(height: 460)
        }
    }
}

struct Post_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        Post(namespace: namespace, show: .constant(true))
    }
}
