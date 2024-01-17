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

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .feed
    @AppStorage("showModal") var showModal = false
    @AppStorage("showSearch") var showSearch: Bool = false
    //var profile: ProfileModel()
    var profile = profiles[0]
    //@EnvironmentObject var model: Model
    
    var body: some View { 
        
        ZStack(alignment: .bottom) {
            
            NavigationView {
                switch selectedTab {
                case .feed:
                    FeedView()
                case .post:
                    //ExploreView()
                    FeedView()
                    //            case .notifications:
                    //                //NotificationsView()
                    //                FeedView()
                case .profile:
                    //                LibraryView()
                    ProfileView(profile: profile)
                    
                }
            }
            
            TabBar()
                .offset(y: showModal ? 200 : 0)
                .animation(.easeInOut(duration: 0.3), value: showModal)
            

        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Color.clear.frame(height: 88)
        }
        //.dynamicTypeSize(.large ... .xxLarge)
        .dynamicTypeSize(.large ... .large)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.sizeCategory, .accessibilityLarge)
            ContentView()
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 13 mini")
        }
        //.environmentObject(Model())
    }
}

