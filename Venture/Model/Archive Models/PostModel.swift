//
//  PostModel.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI

struct PostModel: Identifiable {
    let id = UUID()
    
    //Title refers to the large text summary
    var title: String
    //Info is optional
    var info: String?
    
    //The caption displayed
    var caption: String?
    
    //The list of media to include
    var media: Array <String>
    
    //The username of the person posting
    var username: String
    var profilePicture: String
    
    var numberOfComments: Int
    var friendsMutuals: Array <Int>
    
    var itinerary: ItineraryModel?
}




