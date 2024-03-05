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

struct PostView: View {
    var namespace: Namespace.ID
    var post: PostModel = posts[0] // for preview
    
//    @Binding var show: Bool
    @State private var player: AVPlayer?
    
    //For liking
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
    
    
    
    var profile = profiles[0] // for preview
    var body: some View {
        VStack {
            PostHeader(post: post, profile: profile)
            TabView {
                ForEach(post.media, id: \.self) { mediaItem in

                    ZStack {
                        Image(mediaItem)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width)
                            .clipped()
                            .onTapGesture(count: 2){
                                likeAnimation = true
                                performAnimation()
                                self.isLiked = true
                        }


                        Image(systemName: isLiked ?
                              "cursorarrow.click.2" : "heart.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .scaleEffect(likeAnimation ? 1: 0)
                        .opacity(likeAnimation ? 0.5 : 0)
                        .animation(.spring())
                        .foregroundColor(isLiked ? .red : .black)
                    }



                }

            }.tabViewStyle(PageTabViewStyle())
            .padding(.horizontal, 8)
            .frame(height: 480)
            
            PostFooter(post: post)
            
        }
        
//
//        VStack{
//
//            PostHeader(post: post, profile: profile)
//            //Post and following
//            VStack {
//                Spacer()
//                VStack(alignment: .leading, spacing: 12) {
//                    Group {
//                        Text(post.title)
//                            //.font(.subheadline.weight(.bold))
//                            .animatableFont(size: 18, weight: .bold)
//                            .matchedGeometryEffect(id: "title\(post.id)", in: namespace)
//                            //.opacity(0.5)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        Text(post.caption ?? "")
//                            .font(.footnote)
//                            .fontWeight(.semibold)
//                            //.opacity(0.5)
//                            .matchedGeometryEffect(id: "text\(post.id)", in: namespace)
//                    }
//                    .offset(y: -20)
//
//                }
//                .padding(20)
//                .background(
//                    Rectangle()
//                        .fill(.ultraThinMaterial)
//                        .mask(RoundedRectangle(cornerRadius: 0, style: .continuous))
//                        .blur(radius: 50)
//                        .matchedGeometryEffect(id: "blur\(post.id)", in: namespace)
//                )
//            }
//            .foregroundStyle(.white)
//            .background(
//                //Image("Background 6")
//
//                TabView {
//                    ForEach(post.media, id: \.self) { mediaItem in
//
//                        ZStack {
//                            Image(mediaItem)
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: UIScreen.main.bounds.width)
//                                .clipped()
//                                .onTapGesture(count: 2){
//                                    likeAnimation = true
//                                    performAnimation()
//                                    self.isLiked = true
//                            }
//
//
//                            Image(systemName: isLiked ?
//                                  "bolt.heart" : "heart")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 150, height: 150)
//                            .scaleEffect(likeAnimation ? 1: 0)
//                            .opacity(likeAnimation ? 1 : 0)
//                            .animation(.spring())
//                            .foregroundColor(isLiked ? .red : .black)
//                        }
//
//
//
//                    }
//
//                }.tabViewStyle(PageTabViewStyle())
//
//
//            )
//            .padding(.horizontal, 10)
//            .overlay(
//
//                Button {
//                    self.animateHeart = true
//                    DispatchQueue.main.asyncAfter(deadline: .now() + self.duration, execute: {
//                        self.animateHeart = false
//                        self.isLiked.toggle()
//                    })
//
//                } label: {
//                    Image(systemName: "bolt.heart").imageScale(.large)
//                }
//                .opacity(isLiked ? 1 : 0.3)
//                .accentColor(isLiked ? .red : .white)
//                .scaleEffect(animateHeart ? animationScale : 1)
//                .animation(.easeIn(duration: duration))
//                .padding(.horizontal, 10)
//
//
//
//                ,
//                alignment: .trailing
//
//
//            )
//        .frame(height: 480) //Play around with this for vibes. This is also dynamic based on what the user wants to post.
//
////        PostFooter(post: post)
//        }
        
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
        PostView(namespace: namespace)
    }
}