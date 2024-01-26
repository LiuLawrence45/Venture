//
//  ItineraryModel.swift
//  Venture
//
//  Created by Lawrence Liu on 1/12/24.
//

import SwiftUI

struct ItineraryModel: Identifiable {
    let id = UUID()
    var title: Array <String>
    var caption: Array <String>
    var checklist: String?
}
