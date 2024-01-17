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
                
                Section {
                    VStack(alignment: .center) {
                        Text(title)
                            .multilineTextAlignment(.center)
                            .font(.title3.weight(.semibold))
                                           Divider()
                        if itinerary.caption.count > index {
                            Text(itinerary.caption[index])
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                    Spacer()
                        .frame(height: 20)
                }
                     
            }

            
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


struct ItineraryDescription_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        ItineraryDescription(itinerary: posts[2].itinerary!)
        
        //(namespace: namespace, show: .constant(true))
            //.environmentObject(Model())
    }
}

