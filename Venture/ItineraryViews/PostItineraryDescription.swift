//
//  PostItineraryDescription.swift
//  Venture
//
//  Created by Lawrence Liu on 1/12/24.
//

import SwiftUI

struct PostItineraryDescription: View {
    var itinerary: ItineraryModel?
    
    var body: some View {
        // If an itinerary exists, render ItineraryView; otherwise, do nothing or show a placeholder.
        if let itinerary = itinerary {
            ItineraryDescription(itinerary: itinerary)
        }
    }
}
