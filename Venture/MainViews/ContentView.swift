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
    @State private var showingPhotoPicker = false
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var isEditingPhotos = false
    
    var profile = profiles[0]
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            NavigationView {
                
                VStack(spacing: 0)  {
                    ZStack {
                        switch selectedTab {
                        case .feed:
                            FeedView()
//                                .background(Color.red) Debugging for future frame issues
                            TabBar()
                            
                        case .post:
                            if readyForPhotoEditing {
                                PhotoPicker(selectedItems: $selectedItems) // Assuming PhotoPicker is a view you've defined for editing
                            } else {
                                // Perhaps another view or action to select photos
                                EmptyView() // Placeholder until photos are picked and readyForPhotoEditing is true
                            }
                            TabBar()
                        case .profile:
                            MyProfileView(profile: profile)
//                                .background(Color.blue)  Debugging for future frame issues
                            TabBar()
                            
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
                    

                    
                    // Handling selectedTab is bad... I'm creating a new instance of TabBar each time. This will slow down the UI. Doesn't work since its outside of the ZStack. Not sure, this is something we can optimize later.
                                    //                    if selectedTab != .feed {
                                    //                        TabBar()
                                    //                            .frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 0, maxHeight: .120)
                                    //
                                    //                            .background(Color.purple)
                                    //                    }
                }
            }
            
        }
        .safeAreaInset(edge: .bottom, spacing: 3) {
            Color.clear.frame(height: 68)
//                .background(Color.green)
        }
        .dynamicTypeSize(.large ... .xxLarge)
        //        .dynamicTypeSize(.large ... .large)
        
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


