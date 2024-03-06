//
//  NewPost.swift
//  Venture
//
//  Created by Lawrence Liu on 3/5/24.
//

import SwiftUI
import FirebaseFirestoreSwift

//Post Model
struct Post: Identifiable, Codable, Equatable, Hashable {
    @DocumentID var id: String?
    
    var title: String
    var caption: String
    var location: String
    var cost: String
    var carNeeded: Bool
    var tripItinerary: String
    var people: String
    
    var imageURLs: [URL] = []
    var imageReferenceID: String = ""
    var publishedDate: Date = Date()
    var likedIDs: [String] = []
    var dislikedIDs: [String] = []
    
    //Basic User Information
    var userName: String
    var userUID: String
    var userProfileURL: URL
    
    enum CodingKeys: CodingKey {
        case id
        
        case title
        case caption
        case location
        case cost
        case carNeeded
        case tripItinerary
        case people
        
        case imageURLs
        case imageReferenceID
        case publishedDate
        case likedIDs
        case dislikedIDs
        case userName
        case userUID
        case userProfileURL
    }
    
}
