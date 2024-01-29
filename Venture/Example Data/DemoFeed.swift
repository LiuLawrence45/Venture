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
        title: "ASES BootCamp Trip",
        info: "7 photos",
        caption: "thank you ases bootcamp for everything!",
        media: ["full group ases", "beach", "bridge", "dog" , "car ride", "krish and dawen"],
        username: "liulawrence45",
        profilePicture: "IMG_5155",
        numberOfComments: 3,
        friendsMutuals: [1, 2],
        itinerary: ItineraryModel(
            title: ["🤑 Overall Costs", "🚗 Booking Zip Car","📍 San Gregorio Beach", "📍 Venture Retreat Center"],
            caption: [
                """
                Autogenerated Costs: ~$200 / person, split across hotel and transportation.
                """,
                """
                We booked a ZipCar for a day and night. This came out to around $200 total for a group of 5.
                
                We were in total a group of 30 but it was totally worth it!
                """,
                """
                Quick stop at San Gregorio Beach.
                
                You can sneak in if the guard isn't looking (we paid $0, but you're supposed to pay 15. Life hacks. 😎
                """,
                """
                We finally arrived at Venture Retreat Center.
                
                Super homey; they also had a dog!
                
                We brought fun games, had a formal, etc... totally worth it.
                
                I love you ASES BootCamp! Thank you guys for the great 12 weeks :D
                """
            ],
            images: ["full group ases", "car ride", "beach", "dog"],
            checklist: ""
        )
    ),
    
    PostModel(
        title: "Our ASES Group in SF!",
        info: "10 photos",
        caption: "core memories, best friends forever.",
        media: ["Low Quality Twin Peaks", "Car Ride" , "Chinatown 3", "Fish", "Fish 2", "Twin Peaks Phone", "Chinatown 2", "861A6419"],
        username: "kcheng05",
        profilePicture: "IMG_5155",
        numberOfComments: 1,
        friendsMutuals: [1, 2],
        itinerary: ItineraryModel(
            title: ["🤑 Overall Costs", "🚗 Booking Zip Car", "📍 Basa Seafood Express in Mission District", "📍 Catching Sunset @ Twin Peaks", "📍 Bingsu and Boba @ Sweetheart Cafe"],
            caption: [
                
                """
                Autogenerated Costs: ~$40 / person, split across food and transportation.
                """,
                
                """
                Booked for 8 hours ($115, split 5 ways) and left from Stanford University.
                
                Drove 40 mins to SF. Definitely jam out with friends--Miley Cyrus anyone?
                
                Honestly, any music is fine. We just had the windows down, and enjoyed the beautiful scenery. California can't be missed.
                """,
                """
                Hole-in-the-wall hotspot! Ordered salmon poke and rice for under $10.
                
                ORDER AHEAD! It's such a long wait.
                
                Amogh, when you look back at this, remember all the out-of-pocket things you said. Don't worry, no one else will remember ;)
                """,
                """
                Drove up to a gorgeous viewpoint with all of SF’s lights in view.
                
                Some of the best lights we've ever seen. Thank you SF for the best views <3
                
                San Francisco, you have our hearts. At this moment, we were so so grateful to be here at Stanford.
                """,
                
                """
                A ($11) treat for our sweet tooth. Best bingsu… ever? Chocolate and Strawberry ftw!
                
                Please Lawrence, if you ever look back at this, don't eat all the strawberry BingSu in the future.
                """
//                
//                """
//                Double-double animal style, please! Burgers for <$5. Totally cheap.
//                
//                Comfort food of all students here in the Bay Area.
//                """
            ],
            images: ["861A6374", "Car Ride", "Fish Mart", "Low Quality Twin Peaks", "Bingsuu!"]
        )
        
    ),
    
    
    

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
            title: ["😎 Okada Dorm Rooms are LIT AF!", "🤫 Going to THE Main Quad Now to GET LIT!", "🔥 LIT LATE nights at Branner! The COOLEST Frosh Dorm. "],
            caption: [
                """
                With my friends, Young and Aaron. Shoutout mew boys!!! Get lit!!!
                """,
                """
                Wow this is where the Stanford engineering mind comes from I see... great job guys good work, keep it up, amazing job, wowowwwwww. I loveee Stanford.
                """,
                """
                This was my first time gambling and I won money but I wasn't paid. I never gambled again. Did you know 90% of gamblers give up before their big win? That's what I tell my friends who may have a gambling addiction. HAHA.
                """
            ],
            images: ["71949328572__F6A582E5-6E06-437D-80E5-9F0A5199AA65", "DSCN1352", "IMG_7536"]
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
