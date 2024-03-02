//
//  AppView.swift
//  Venture
//
//  Created by Lawrence Liu on 3/1/24.
//

import SwiftUI

struct AppView: View {
    
    @StateObject var model = Model()
    @State var isAuthenticated = false
    
    var body: some View {
        Group {
            if isAuthenticated {
                ContentView()
                    .environmentObject(model)
                    // .statusBarHidden(true) // This is a temporary measure just since I can't figure it out right now.
            }
            else {
                ParentView()
                    .environmentObject(model)
                    // .statusBarHidden(true)
            }
        }
        .task {
            for await state in await supabase.auth.authStateChanges {
                if [.initialSession, .signedIn, .signedOut].contains(state.event) {
                    isAuthenticated = state.session != nil
                }
            }
        }
    }
}

#Preview {
    AppView()
}
