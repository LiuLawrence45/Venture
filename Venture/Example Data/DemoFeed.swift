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
//var posts : [PostModel] = profiles.flatMap { $0.posts }

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
    ),
    
    PostModel(
        title: "Our Annual ASES Retreat",
        info: "6 photos, 1 video",
        caption: "Good friends, food, and really cold weather!",
        media: ["IMG_8239", "IMG_1437", "IMG_8224", "IMG_0021", "IMG_7749", "DSCN1457"],
        username: "liu.lawrence45",
        profilePicture: "04B0D33D-83BB-4E23-BE56-50EFA4FB1B7C",
        numberOfComments: 10,
        friendsMutuals: [15, 15],
        itinerary: ItineraryModel(
            title: ["Driving to the Venture Retreat Center", "Beach Pit Stop", "Formal Night"],
            caption: [
                """
                We started off with a quick drive to the venture retreat center: https://www.ventureretreat.org
                
                Some info about Venture Retreat:
                       1. Pricing was relatively well-off, around $1k per night for 30+.
                       2. You basically live in huts (if you see on the website). Worth it for the experience.
                       3. There's a pool advertised as well: you won't be able to swim most likely from Oct. - March because of the cold.
                
                The car ride was super fun. The road is extremely windy close to the home though, so be careful!
                """,
                
                """
                We made a quick beach stop at San Gregorio State Beach. We honestly were supposed to get to the retreat center on time,
                but thankfully we stopped.
                
                Truly just something out of a movie.
                
                Future Recs: Definitely stop at any beaches you see.
                """,
                
                """
                fun formal night with all friends and digicams!
                """
            ]
            //checklist: ""
        )
    ),
    
    PostModel(
        title: "half-moon bay adventure!",
        info: "7 photos",
        caption: "fun w my friends :)",
        media: ["IMG_5136", "IMG_5137", "IMG_5169", "IMG_5171" , "IMG_5186", "IMG_5204"],
        username: "kcheng05",
        profilePicture: "IMG_5155",
        numberOfComments: 2,
        friendsMutuals: [1, 2],
        itinerary: ItineraryModel(
            title: ["stop by trader joes", "visit lake", "half moon bay!"],
            caption: [
                """
                """
            ],
            checklist: ""
        )
    )
    

]
