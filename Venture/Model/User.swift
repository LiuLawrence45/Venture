//
//  User.swift
//  Venture
//
//  Created by Lawrence Liu on 3/2/24.
//

import SwiftUI
import FirebaseFirestoreSwift

struct User: Identifiable, Codable{
    @DocumentID var id: String?
    var username: String
    var firstName: String?
    var lastName: String?
    var userBio: String?
    var userBioLink: String?
    var school: String?
    var userUID: String?
    var userEmail: String
    var userProfileURL: URL?
    
    enum CodingKeys: CodingKey {
        case id
        case username
        case firstName
        case lastName
        case userBio
        case userBioLink
        case school
        case userUID
        case userEmail
        case userProfileURL
    }
    
}
