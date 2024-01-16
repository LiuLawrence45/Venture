//
//  FeedView.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI

struct FeedView: View {
    @State var hasScrolled = false
    @Namespace var namespace
    @State var show = false
    @State var showStatusBar = true
    @State var selectedID = UUID()
    @State var showCourse = false
    @State var selectedIndex = 0
    @AppStorage("isLiteMode") var isLiteMode = true
    @AppStorage("showModal") var showModal = false

    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()

            ScrollView {
                scrollDetection

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 20)], spacing: 40) {
                    if !show {
                        cards
                    } else {
                        ForEach(posts) { post in
                            Rectangle()
                                .fill(.white)
                                .frame(height: 300)
                                .cornerRadius(60)
                                .shadow(color: Color("Shadow"), radius: 20, x: 0, y: 10)
                                .opacity(0.3)
                            .padding(.horizontal, 30)
                        }
                    }
                }
                .padding(.horizontal, 10 )
                
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.0))
                    .frame(height: 75)
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay(
                NavigationBar(title: "Journeys",
                              hasScrolled: $hasScrolled
                             )
            )

            if show {
                detail
            }
        }
        .statusBar(hidden: !showStatusBar)
        
        //iOS 17
        .onChange(of: show) {
            withAnimation(.closeCard) {
                if show == true {
                    showStatusBar = false
                    showModal = true
                }
                else {
                    showStatusBar = true
                    showModal = false
                }
            }
        }
        

    }

    var scrollDetection: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            withAnimation(.easeInOut) {
                if value < 0 {
                    hasScrolled = true
                } else {
                    hasScrolled = false
                }
            }
        })
    }

    var cards: some View {
        ForEach(posts) { post in
            Post(namespace: namespace, post: post, show: $show)
                .gesture(TapGesture(count: 2).onEnded {
                    
                }.exclusively(before: TapGesture(count: 1).onEnded {
                    withAnimation(.openCard) {
                        show.toggle()
                        //model.showDetail.toggle()
                        showStatusBar = false
                        selectedID = post.id
                    }
                }))
//                .onTapGesture(count: 2) {
//                    
//                }
//                .onTapGesture(count: 1){
//                    withAnimation(.openCard) {
//                        show.toggle()
//                        //model.showDetail.toggle()
//                        showStatusBar = false
//                        selectedID = post.id
//                    }
//                }
                .accessibilityElement(children: .combine)
                .accessibilityAddTraits(.isButton)
        }
    }

    var detail: some View {
        ForEach(posts) { post in
            if post.id == selectedID {
                ItineraryView(namespace: namespace, post: post, show: $show)
                    .zIndex(1)
                    .transition(.asymmetric(
                        insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                        removal: .opacity.animation(.easeInOut(duration: 0.2).delay(0.1))))
            }
        }
    }
}

#Preview {
    FeedView()
}
