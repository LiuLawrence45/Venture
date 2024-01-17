//
//  DemoFeed.swift
//  Venture
//
//  Created by Lawrence Liu on 1/11/24.
//

import SwiftUI

/*
 Feed aggregated variable for now. In future, this should be retrieved through backend
 */
var posts = [
    PostModel(
        title: "bedbunk x10",
        info: "",
        caption: "once in a lifetime experience",
        media: ["DSCN1352", "IMG_6986", "IMG_7536", "IMG_7546", "IMG_7559", "71949328572__F6A582E5-6E06-437D-80E5-9F0A5199AA65"],
        username: "liu.lawrence45",
        profilePicture: "04B0D33D-83BB-4E23-BE56-50EFA4FB1B7C",
        numberOfComments: 6,
        friendsMutuals: [10, 4],
        itinerary: ItineraryModel(
            title: ["dorm rooms in okada", "go to main quad", "late nights at branner?"],
            caption: [
                """
                """,
                """
                """
            ],
            checklist: ""
        )
    )

]
