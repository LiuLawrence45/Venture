////
////  Post.swift
////  Venture
////
////  Created by Lawrence Liu on 1/11/24.
////
//
//
///*
// Default post formatting for feed display.
// */
//
//import SwiftUI
//import AVKit
//
//struct OldPostView: View {
//    var namespace: Namespace.ID
//    var post: PostModel = demoPosts[0] // for preview
//    
////    @Binding var show: Bool
//    @State private var player: AVPlayer?
//    
//    //For liking
//    @State private var animateHeart = false
//    @State private var likeAnimation = false
//    @State private var isLiked = false
//    @State private var isDown = false
//    private let duration: Double = 0.2
//    private var animationScale: CGFloat{
//        isLiked ? 0.6 : 2.0
//    }
//    
//    func performAnimation(){
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
//            likeAnimation = false
//        }
//    }
//    
//    
//    
//    var profile = profiles[0] // for preview
//    var body: some View {
//        VStack {
//            PostHeader(post: post, profile: profile)
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
//            
//            PostFooter(post: post)
//            
//        }
//        
//    }
//
//}
//
//private func isVideo(_ mediaItem: String) -> Bool {
//    // Implement logic to determine if the media item is a video
//    // For example, check the file extension
//    return mediaItem.hasSuffix(".mp4") || mediaItem.hasSuffix(".mov") // Example condition
//}
//
//
//
//struct OldPostView_Previews: PreviewProvider {
//    @Namespace static var namespace
//    
//    static var previews: some View {
//        //Post(namespace: namespace, show: .constant(true))
//        OldPostView(namespace: namespace)
//    }
//}
