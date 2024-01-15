//
//  NotificationModel.swift
//  Venture
//
//  Created by Lawrence Liu on 1/12/24.
//

import SwiftUI

struct NotificationInformation: Identifiable {
    let id = UUID()
    var name: String
    var action: String
    var image: String
}
