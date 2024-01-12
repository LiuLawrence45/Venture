//
//  ItineraryDescription.swift
//  Venture
//
//  Created by Lawrence Liu on 1/12/24.
//

import SwiftUI



/*
 Formatting for the Itinerary Description
 */

struct ItineraryDescription: View {
    var itinerary: ItineraryModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(Array(zip(itinerary.title.indices, itinerary.title)), id: \.0) { index, title in
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title3.weight(.semibold))
                    Spacer(minLength: 8) // Adjust this value as needed
                                       Divider()
                                       Spacer(minLength: 8)
//                    Spacer()
//                    Divider()
//                    Spacer()
                    if itinerary.caption.count > index {
                        Text(itinerary.caption[index])
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                    
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
            
            if let checklistItems = itinerary.checklist?.components(separatedBy: "\n") {
                ChecklistView(items: checklistItems)
            }
        }
        .padding(20)
    }
}

struct ChecklistView: View {
    let items: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(items, id: \.self) { item in
                HStack {
                    Image(systemName: "checkmark.circle")
                    Text(item)
                }
                .padding(.vertical, 2)
            }
        }
        .padding(.horizontal)
    }
}
