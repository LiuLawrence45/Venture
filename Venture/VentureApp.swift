//
//  VentureApp.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI
import Foundation
import Firebase

@main
struct VentureApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}
