//
//  PostModel.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI

struct PostModel: Identifiable {
    let id = UUID()
    var title: String
    var info: String?
    var caption: String?
    var images: Array <String>
    var author: String
    var itinerary: ItineraryModel?
}




