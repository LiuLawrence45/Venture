//
//  ProfileModel.swift
//  Venture
//
//  Created by Lawrence Liu on 1/17/24.
//

import SwiftUI

struct ProfileModel: Identifiable {
    
    let id = UUID()
    var profilePicture: String
    var firstName: String
    var lastName: String
    var username: String
    var gender: String
    var school: String
    var occupation: String
    
    var profileDescription: String
    
    
    var numFriends: Int
    
    var posts: Array <PostModel>
    
    var bucketList: Array <String>
    var downToGo: Array <PostModel>
    
    
    
}
