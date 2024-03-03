//
//  Tab.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
    var color: Color
}

var tabItems = [
//    TabItem(text: "Journeys", icon: "figure.run", tab: .feed, color: .teal),
//    TabItem(text: "Post", icon: "timelapse", tab: .post, color: .blue),
//    TabItem(text: "Profile", icon: "person.crop.circle", tab: .profile, color: .pink)
    
    TabItem(text: "Journeys", icon: "figure.run", tab: .feed, color: .white),
    TabItem(text: "Post", icon: "timelapse", tab: .post, color: .white),
    TabItem(text: "Profile", icon: "person.crop.circle", tab: .profile, color: .white) 
]

enum Tab: String {
    case feed
    case post
    case profile
}

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
