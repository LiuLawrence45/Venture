//
//  ContentView.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//


/*
 Overall view for app
 */

import SwiftUI
import PhotosUI

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .feed
    @AppStorage("showModal") var showModal = false
    @AppStorage("showSearch") var showSearch: Bool = false
    @State private var readyForPhotoEditing = false
    @EnvironmentObject var model: Model
    
    
    //For showing photo picker
    @State private var createNewPost: Bool = false
    
    var profile = profiles[0]
    
    
    //For feed
    @State private var recentPosts: [Post] = []
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            NavigationView {
                
                VStack(spacing: 0)  {
                    ZStack {
                        switch selectedTab {
                        case .feed:
                            FeedView(posts: $recentPosts)
                            TabBar()
                            
                        case .post:
                            EmptyView()
                            TabBar()
                        case .profile:
                            MyProfileView(profile: profile)
//                                .background(Color.blue)  Debugging for future frame issues
                            TabBar()
                            
                        }
                    }
                }
                .onChange(of: selectedTab) { newValue in
                    if newValue == .post {
                        createNewPost = true
                    }
                    else {
                        createNewPost = false
                    }
                }
                .fullScreenCover(isPresented: $createNewPost){
                    CreateNewPost { post in
                        print("Hello")
                    }
                }
            }
            
        }

        .safeAreaInset(edge: .bottom, spacing: 3) {
            Color.clear.frame(height: 68)
        }
        .dynamicTypeSize(.large ... .xxLarge)
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.sizeCategory, .accessibilityLarge)
                .environmentObject(Model())
        }
    }
}


