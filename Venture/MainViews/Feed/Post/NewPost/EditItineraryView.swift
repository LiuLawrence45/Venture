//
//  EditItineraryView.swift
//  Venture
//
//  Created by Lawrence Liu on 3/6/24.
//

import SwiftUI

struct EditItineraryView: View {
    
    @Binding var isPresented: Bool
    @Binding var tripItinerary: String
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationView {
                    VStack {
                        TextEditor(text: $tripItinerary)
                            .padding()
//                            .border(Color.gray, width: 1)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.primary)
                            .font(.body)
                        
                        // Add other UI elements for formatting if needed
                    }
//                    .padding()
                    .navigationTitle("✏️ Edit Itinerary")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                dismiss()
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                dismiss()
                            }
                        }
                    }
                    .foregroundColor(.primary)
                }
    }
}

//#Preview {
//    EditItineraryView()
//}
