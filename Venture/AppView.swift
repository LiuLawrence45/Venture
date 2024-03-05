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
    
    var body: some View {
        Group {
            if logStatus {
                CreateNewPost{_ in}
                //ContentView()
                    .environmentObject(model)
                    // .statusBarHidden(true) // This is a temporary measure just since I can't figure it out right now.
            }
            else {
                ParentView()
                    .environmentObject(model)
                    // .statusBarHidden(true)
            }
        }
    }
}

#Preview {
    AppView()
}
