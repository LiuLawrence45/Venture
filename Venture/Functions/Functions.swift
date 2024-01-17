//
//  Functions.swift
//  Venture
//
//  Created by Lawrence Liu on 1/17/24.
//

import SwiftUI


func findProfile(username: String, profiles: [ProfileModel]) -> ProfileModel? {
    for profile in profiles {
        if profile.username == username {
            return profile
        }
    }
    
    return nil
}
