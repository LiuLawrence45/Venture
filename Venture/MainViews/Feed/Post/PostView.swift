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
import AVKit
import SDWebImageSwiftUI

struct PostView: View {
//    var namespace: Namespace.ID
    
    //Preview variables
//    var post: PostModel = demoPosts[0]
    var post: Post
    var profile = profiles[0]

    //Possible video player in the future
    @State private var player: AVPlayer?
    
    //For liking posts
    @State private var animateHeart = false
    @State private var likeAnimation = false
    @State private var isLiked = false
    @State private var isDown = false
    private let duration: Double = 0.2
    private var animationScale: CGFloat{
        isLiked ? 0.6 : 2.0
    }
    
    func performAnimation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            likeAnimation = false
        }
    }
    
    // Callbacks for functions
    var onUpdate: (Post) -> ()
    var onDelete: () -> ()
    

    var body: some View {
        VStack {
//            PostHeader(post: post)    This is outdated. Let's create from scratch below.
            HStack {
                WebImage(url: post.userProfileURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 36, height: 36)
                    .mask(Circle())
                
                VStack(alignment: .leading){
                    
                    
                    //This was originally a button.
                    Text(post.userName)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                        .fontWeight(.semibold)
                        .frame(alignment: .leading)
                    
                    Text(post.publishedDate.formatted(date: .numeric, time: .shortened))
                    .font(.caption2)
                    .multilineTextAlignment(.trailing)
                    .frame(alignment: .trailing)
                    .opacity(0.6)
                    
                    Text(post.text)
                        .textSelection(.enabled)
                        .padding(.vertical, 8)
                    
                    if let postImageURL = post.imageURL.first{
                        GeometryReader {
                            let size = $0.size
                            WebImage(url: postImageURL)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipped()
                        }
                        .frame(height: 200)
                    }
                    
                }
            }
//            
//            TabView {
//                ForEach(post.media, id: \.self) { mediaItem in
//
//                    ZStack {
//                        Image(mediaItem)
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: UIScreen.main.bounds.width)
//                            .clipped()
//                            .onTapGesture(count: 2){
//                                likeAnimation = true
//                                performAnimation()
//                                self.isLiked = true
//                        }
//
//
//                        Image(systemName: isLiked ?
//                              "cursorarrow.click.2" : "heart.circle")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 150, height: 150)
//                        .scaleEffect(likeAnimation ? 1: 0)
//                        .opacity(likeAnimation ? 0.5 : 0)
//                        .animation(.spring())
//                        .foregroundColor(isLiked ? .red : .black)
//                    }
//
//
//
//                }
//
//            }.tabViewStyle(PageTabViewStyle())
//            .padding(.horizontal, 8)
//            .frame(height: 480)
            
            //PostFooter(post: post)
            
        }
        
    }

}

private func isVideo(_ mediaItem: String) -> Bool {
    // Implement logic to determine if the media item is a video
    // For example, check the file extension
    return mediaItem.hasSuffix(".mp4") || mediaItem.hasSuffix(".mov") // Example condition
}



struct PostView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        //Post(namespace: namespace, show: .constant(true))
//        PostView(namespace: namespace)
        ContentView()
    }
}
