//
//  VentureApp.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI
import Foundation
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct VentureApp: App {
    
    @Environment(\.colorScheme) var colorScheme

    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.colorScheme, .dark)
        }
    }
}
