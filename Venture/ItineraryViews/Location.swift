//
//  Location.swift
//  Venture
//
//  Created by Lawrence Liu on 1/28/24.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double 
}
