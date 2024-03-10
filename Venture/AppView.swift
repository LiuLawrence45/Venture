//
//  AppView.swift
//  Venture
//
//  Created by Lawrence Liu on 3/1/24.
//

import SwiftUI

struct AppView: View {
    
    @StateObject var model = Model()
    @AppStorage("log_status") var logStatus: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Group {
            if logStatus {
//                CreateNewPost{_ in}
                ContentView()
                    .environmentObject(model)
                    .environment(\.colorScheme, .dark)
                    // .statusBarHidden(true) // This is a temporary measure just since I can't figure it out right now.
//                    .environment(\.font, Font.custom("Raleway", size: 14))
            }
            else {
                ParentView()
                    .environmentObject(model)
                    .preferredColorScheme(.dark)
//                    .environment(\.font, Font.custom("Raleway", size: 14))
                    // .statusBarHidden(true)
            }
        }
    }
}

#Preview {
    AppView()
}
