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
    
    
    //For showing photo picker
    @State private var showingPhotoPicker = false
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var isEditingPhotos = false
    
    var profile = profiles[0]
    
    var body: some View { 
        
        ZStack(alignment: .bottom) {
             
            NavigationView {
                switch selectedTab {
                case .feed:
                    FeedView()
                case .post:
                    if readyForPhotoEditing {
                        PhotoPicker(selectedItems: $selectedItems) // Assuming PhotoPicker is a view you've defined for editing
                    } else {
                        // Perhaps another view or action to select photos
                        EmptyView() // Placeholder until photos are picked and readyForPhotoEditing is true
                    }
                case .profile:
                    ProfileView(profile: profile)
                    
                }
            }
            .onChange(of: selectedTab) { newTab in
                if newTab == .post {
                    showingPhotoPicker = true
                }
            }
            .photosPicker(isPresented: $showingPhotoPicker, selection: $selectedItems, matching: .images, photoLibrary: .shared())
            .onChange(of: selectedItems) { _ in
                if !selectedItems.isEmpty {
                    readyForPhotoEditing = true
                }
            }

            
            TabBar()
                .offset(y: showModal ? 200 : 0) 
                .animation(.easeInOut(duration: 0.3), value: showModal)
            

        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Color.clear.frame(height: 78)
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
        }
    }
}


