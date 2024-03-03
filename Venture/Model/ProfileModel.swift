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
//
//struct Profile: Decodable {
//    
//    //Controllable
//    //let profilePicture: String?
//    let username: String?
//    let firstName: String?
//    let lastName: String?
//    let gender: String?
//    let school: String?
//    let occupation: String?
//    let profileDescription: String?
//
//
//    enum CodingKeys: String, CodingKey {
//        case username
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case gender
//        case school
//        case occupation
//        case profileDescription = "profile_description"
//    }
//}
//
//struct UpdateProfileParams: Encodable {
//    
//    //Controllable
//    //let profilePicture: String?
//    let username: String?
//    let firstName: String?
//    let lastName: String?
//    let gender: String?
//    let school: String?
//    let occupation: String?
//    let profileDescription: String?
//
//
//    enum CodingKeys: String, CodingKey {
//        case username
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case gender
//        case school
//        case occupation
//        case profileDescription = "profile_description"
//    }
//}
