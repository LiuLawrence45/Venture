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
import SDWebImageSwiftUI

struct PostView: View {
    
    //Only necessary variable.
    var post: Post
    
    // Callbacks for functions
    var onUpdate: (Post) -> ()
    var onDelete: () -> ()
    

    var body: some View {
        VStack {
            
            //Post heading information (username, time, etc...)
            PostHeader(post: post)
            
            
            NavigationLink(destination: ItineraryView(post: post)) {
                //All images in the horizontal carousel
                TabView {
                    ForEach(post.imageURLs, id: \.self){ imageURL in
                        ZStack {
                            WebImage(url: imageURL)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width - 16, height: 480)

                                .clipped()
                                
                        }
                        
                    }
                }
                .tabViewStyle(PageTabViewStyle())
            }
            .frame(height: 480)
            .padding(.horizontal, 8)

            
            
            //Post footing information. GUI change soon.
            PostFooter(post: post)
        }
        
    }
    
    

        

}


struct PostView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        
//        Post(namespace: namespace, show: .constant(true))
//        PostView(post: <#Post#>, onUpdate: <#(Post) -> ()#>, onDelete: <#() -> ()#>)
        ContentView()
    }
}
