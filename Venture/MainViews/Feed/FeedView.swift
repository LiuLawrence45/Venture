////
////  FeedView.swift
////  Venture
////
////  Created by Lawrence Liu on 1/11/24.
////
//
//import SwiftUI
//
//struct FeedView: View {
//    
//    var columns = [GridItem(.adaptive(minimum: 300), spacing: 20)]
//    
//    @State private var tabBar: UITabBar! = nil
//    
//    @State var show = false
//    @State var showPost = false
//    @State var selectedPost: PostModel = demoPosts[0]
//    @State var contentHasScrolled = false
//    
//    @EnvironmentObject var model: Model
//    @Namespace var namespace
//    
//    var body: some View {
//        ZStack {
//            
//            //Either we want VSCO vibe or this. Change background color.
////            Color("Background").ignoresSafeArea()
//            
////            if model.showDetail {
////                detail
////            }
//            
//            ScrollView(showsIndicators: false){
//                scrollDetection
//                
//                LazyVGrid(columns: columns, spacing: 20) {
//                    showPosts
//                        .padding(.bottom, 10)
//                }
//                .offset(y: 68)
//                
//
//            }
//            .coordinateSpace(name: "scroll")
//        }
//        .onChange(of: model.showDetail) {value in
//            withAnimation {
//                model.showTab.toggle()
//                print("Hello")
//            }
//        }
//        .overlay(NavigationBar(title: "Featured", context: "default", hasScrolled: $contentHasScrolled))
//    }
//    
//    var showPosts: some View {
//        ForEach(demoPosts) { post in
//            NavigationLink(destination: ItineraryView(post: post)){
//                PostView(namespace: namespace, post: post)
//                    .accessibilityElement(children: .combine)
//                    .accessibilityAddTraits(.isButton)
//            }
//            .accentColor(.primary)
////            .onAppear {
////                withAnimation(.easeIn) {
////                    print("Appear")
////                    model.showTab = false
////                }
////            }
////            .onDisappear {
////                withAnimation(.easeOut){
////                    print("Disappear")
////                    model.showTab = true
////                }
////            }
//
//        }
//    }
//    
//    
//    var scrollDetection: some View {
//        GeometryReader { proxy in
//            let offset = proxy.frame(in: .named("scroll")).minY
//            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
//        }
//        .onPreferenceChange(ScrollPreferenceKey.self) { value in
//            withAnimation(.easeInOut) {
//                if value < 0 {
//                    contentHasScrolled = true
//                } else {
//                    contentHasScrolled = false
//                }
//            }
//        }
//    }
//
//}
//
//#Preview {
//    FeedView()
//        .environmentObject(Model())
//}
//
//
//
