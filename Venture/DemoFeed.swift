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
        title: "Berkeley Nights Uncovered",
        info: "15 photos - 2 videos",
        caption: "Exploring the urban jungle after dark",
        images: ["Background 5", "Background 4", "Background 3"],
        author: "Logo 3",
        itinerary: ItineraryModel(
            title: ["Hike at Bear Mountain", "Visit the Lake"],
            caption: [
                """
                Your adventure begins with a late afternoon hike at Bear Mountain. The trail is moderately challenging but offers some of the most spectacular sunset views over the Berkeley skyline. 
                
                Be sure to pack extra layers as the temperature can drop quickly after sunset, and a headlamp or flashlight is essential for the return journey.
                
                The path can be rocky, so sturdy hiking shoes are a must. Don't forget to pause at the summit and enjoy the panoramic views of the city lights starting to twinkle below.
                """,
                """
                The second part of your night takes you to a serene lake setting. Ideal for a romantic evening or a tranquil solo outing. Pack a picnic blanket and some snacks – maybe even a bottle of local wine. 
                
                The lake's calm waters reflect the city lights, creating a mesmerizing view. If you're visiting during the day, stop by Bay Family Farms near the lake entrance for some fresh sunflowers; it's $15 per adult, $10 per child.
                
                The area can get muddy post-rain, so wear appropriate shoes.
                """
            ],
            checklist: "Pack extra layers\nHeadlamp or flashlight\nSturdy hiking shoes\nPicnic blanket\nSnacks\nOptional: sunflower budget"
        )
    ),
    
    PostModel(
        title: "Tech Trek at The Gates",
        info: "18 photos - 4 videos",
        caption: "A geek's paradise at the famous Gates Building",
        images: ["Background 5", "Background 4", "Background 2"],
        author: "Logo 4",
        itinerary: ItineraryModel(
            title: ["Campus Tech Tour", "Evening Coding Workshop"],
            caption: [
                """
                Start your day with a guided tour of the campus, focusing on the Gates Building. It's not just a building but a hub of innovation and technology. Explore the labs where new software and apps are developed. The tour guides are usually students or faculty, offering a personal insight into life at one of the world's leading tech universities. 
                
                Make sure to wear comfortable shoes as there’s a lot of ground to cover.
                """,
                """
                In the evening, participate in a coding workshop held in one of the computer labs. Whether you're a beginner or looking to polish your skills, these workshops are a fantastic opportunity to learn and network. 
                
                They often feature guest speakers from renowned tech companies. Don't forget to bring your laptop and charger. If you're lucky, you might also get some insider tips on the latest tech trends.
                """
            ],
            checklist: "Comfortable walking shoes\nNotebook and pen\nLaptop and charger\nCuriosity and questions for the workshop"
        )
    ),
    
    PostModel(
        title: "Rooftop Rendezvous",
        info: "12 photos - 3 videos",
        caption: "Scaling heights for breathtaking views",
        images: ["Background 6", "Background 4", "Background 1"],
        author: "Logo 1",
        itinerary: ItineraryModel(
            title: ["Urban Exploration", "Secret Rooftop Garden"],
            caption: [
                """
                Begin your urban exploration adventure by navigating the city's less-traveled paths to discover hidden rooftop gems. This activity is perfect for urban photographers and adventure seekers. 
                
                Make sure to wear comfortable, non-slip shoes as you'll be climbing stairs and possibly navigating uneven surfaces. Bring a camera with a good zoom lens to capture the unique aerial perspectives of the cityscape.
                
                Always be mindful of safety and respect private property.
                """,
                """
                The secret rooftop garden is your next stop, a lush green oasis amidst the urban sprawl. Here, you can relax, meditate, or simply enjoy the contrast between nature and the city. 
                
                It's a fantastic spot for panoramic photography or a quiet picnic. Pack a light meal, a good book, and perhaps some sketching materials if you're artistically inclined.
                
                The tranquility of this place offers a perfect break from the bustling city life below.
                """
            ],
            checklist: "Comfortable, non-slip shoes\nCamera with zoom lens\nLight picnic meal\nBook or sketchpad\nWater bottle"
        )
    ),
    PostModel(
        title: "Golden Gate Gala",
        info: "22 photos - 5 videos",
        caption: "Basking in the glory of the iconic bridge",
        images: ["Background 7", "Background 6", "Background 2"],
        author: "Logo 5",
        itinerary: ItineraryModel(
            title: ["Bridge Bike Tour", "Sunset Picnic"],
            caption: [
                """
                Embark on a scenic bike ride across the Golden Gate Bridge. 
                
                Rent a bike from one of the many nearby shops. The ride provides spectacular views of the bay and the city skyline. The path can be breezy and a bit chilly, so wear layered clothing.
                
                Make sure to stop at Vista Point on the other side for some stunning photo ops of the bridge and San Francisco in the background.
                """,
                """
                After the bike ride, unwind with a sunset picnic at a nearby park with views of the bridge. Pack a cozy blanket, some local artisanal snacks, and a thermos of hot beverage to enjoy as the sun sets. 
                
                This is an ideal time for photographers to capture the bridge in the golden light, and for couples to enjoy a romantic moment.
                """
            ],
            checklist: "Bike rental\nLayered clothing\nCamera\nPicnic blanket\nArtisanal snacks\nThermos with hot beverage"
        )
    ),
    PostModel(
        title: "Sunset Surf at Santa Cruz",
        info: "20 photos - 6 videos",
        caption: "Riding the waves as the sun dips",
        images: ["Background 8", "Background 7", "Background 3"],
        author: "Logo 6",
        itinerary: ItineraryModel(
            title: ["Morning Surf Session", "Boardwalk Excursion", "Evening Beach Relaxation"],
            caption: [
                """
                Kick off your day with an invigorating morning surf session at one of Santa Cruz's renowned beaches. Surfboard rentals and lessons are available for all skill levels. 
                
                The waves here are perfect for beginners and intermediates.
                
                Don't forget to apply waterproof sunscreen and wear a wetsuit for comfort in the cool Pacific waters.
                """,
                """
                Spend your afternoon at the vibrant Santa Cruz Boardwalk. Enjoy classic amusement park rides, try local seafood, and don't miss the delicious saltwater taffy. The boardwalk is a bustling hub of activity with something for everyone – from thrilling rides to arcade games.
                """,
                """
                End your day with a relaxing evening on the beach, watching the sunset over the ocean. Bring a beach blanket, a light jacket as it can get chilly, and some snacks. 
                
                This is a perfect time for reflection, relaxation, and capturing the beauty of a California sunset on camera.
                """
            ],
            checklist: "Surfboard rental\nWaterproof sunscreen\nWetsuit\nBeach blanket\nLight jacket\nSnacks\nCamera"
        )
    ),
    
    PostModel(
        title: "Napa Valley Vines",
        info: "16 photos - 2 videos",
        caption: "Savoring the flavors of wine country",
        images: ["Background 9", "Background 8", "Background 4"],
        author: "Logo 7",
        itinerary: ItineraryModel(
            title: ["Vineyard Tours", "Wine Tasting", "Gourmet Dinner"],
            caption: [
                """
                Start your journey through the rolling hills of Napa Valley with a guided vineyard tour. You'll walk among the vines, learn about different grape varieties, and the winemaking process. 
                
                Comfortable walking shoes are essential as the terrain can vary. Don't forget your camera to capture the picturesque landscape and maybe even a selfie with the vineyard in the background.
                """,
                """
                Next, indulge in a wine tasting session at one of Napa's renowned wineries. Savor a selection of local wines, each with its unique flavor profile, guided by an expert sommelier. 
                
                It's a perfect opportunity to broaden your palate and learn about wine pairing. Keep a notebook handy to jot down your favorites.
                """,
                """
                Conclude your day with a gourmet dinner at a local restaurant. 
                
                Napa is known for its farm-to-table cuisine, perfectly complementing the wine. Reserve a table in advance to avoid disappointment, especially during peak season. Enjoy the ambiance, the food, and maybe a glass of wine you discovered earlier in the day.
                """
            ],
            checklist: "Comfortable walking shoes\nCamera\nWine tasting notebook\nDinner reservation\nAn appetite for exploration"
        )
    ),
    PostModel(
        title: "Mountain Adventures",
        info: "25 photos - 4 videos",
        caption: "Exploring the natural wonders of the mountains nearby",
        images: ["Background 10", "Background 9", "Background 5"],
        author: "Logo 8",
        itinerary: ItineraryModel(
            title: ["Guided Hike", "Wildlife Photography", "Campfire Evening"],
            caption: [
                """
                Embark on a guided hike through the mountain trails. These hikes can vary from easy walks to challenging climbs, so choose one that suits your fitness level. A local guide can provide insights into the area's history and ecology. 
                
                Remember to pack plenty of water, some energy snacks, and a first-aid kit for safety.
                """,
                """
                For photography enthusiasts, the mountains are a haven for wildlife. Bring your camera and a good lens to capture shots of local birds, deer, and other fauna. Patience is key, so find a comfortable spot and wait for the perfect moment. 
                
                Binoculars can also enhance your wildlife spotting experience.
                """,
                """
                As the evening sets in, gather around a campfire (where permitted). 
                
                It's a time for sharing stories, roasting marshmallows, and enjoying the starry sky.
                
                Pack some campfire essentials like firewood (if allowed), matches, and a warm blanket. It's an ideal way to end a day of mountain adventures.
                """
            ],
            checklist: "Hiking gear\nWater and snacks\nFirst-aid kit\nCamera and lens\nBinoculars\nCampfire essentials\nWarm blanket"
        )
    )
]
