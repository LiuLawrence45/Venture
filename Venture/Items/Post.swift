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
        VStack{
            
            
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
            
            
            
            
            //Post and following
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
            
        Text("View all 2 comments...")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.vertical, 2)
                .opacity(0.5)
                .font(.footnote)
        }
        
    }

}



struct Post_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        Post(namespace: namespace, show: .constant(true))
    }
}
