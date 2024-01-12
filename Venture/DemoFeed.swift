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
    PostModel(title: "Berkeley Nights Uncovered",
              info: "15 photos - 2 videos",
              caption: "Exploring the urban jungle after dark",
              images: ["Background 5", "Background 4", "Background 3"],
              author: "Logo 3"),
    
    PostModel(title: "Tech Trek at The Gates",
              info: "18 photos - 4 videos",
              caption: "A geek's paradise at the famous Gates Building",
              images: ["Background 5", "Background 4", "Background 2"],
              author: "Logo 4"),
    
    PostModel(title: "Rooftop Rendezvous",
              info: "12 photos - 3 videos",
              caption: "Scaling heights for breathtaking views",
              images: ["Background 6", "Background 4", "Background 1"],
              author: "Logo 1"),
    
    PostModel(title: "Golden Gate Gala",
              info: "22 photos - 5 videos",
              caption: "Basking in the glory of the iconic bridge",
              images: ["Background 7", "Background 6", "Background 2"],
              author: "Logo 5"),
    
    PostModel(title: "Sunset Surf at Santa Cruz",
              info: "20 photos - 6 videos",
              caption: "Riding the waves as the sun dips",
              images: ["Background 8", "Background 7", "Background 3"],
              author: "Logo 6"),
    
    PostModel(title: "Napa Valley Vines",
              info: "16 photos - 2 videos",
              caption: "Savoring the flavors of wine country",
              images: ["Background 9", "Background 8", "Background 4"],
              author: "Logo 7"),
    
    PostModel(title: "Mountain Adventures",
              info: "25 photos - 4 videos",
              caption: "Exploring the natural wonders of the mountains nearby",
              images: ["Background 10", "Background 9", "Background 5"],
              author: "Logo 8"),
    
    PostModel(title: "L.A. Lights",
              info: "18 photos - 3 videos",
              caption: "Discovering the City of Angels",
              images: ["Background 1", "Background 10", "Background 6"],
              author: "Logo 9"),
    
    PostModel(title: "San Diego Sunsets",
              info: "15 photos - 2 videos",
              caption: "Capturing the essence of evenings in San Diego",
              images: ["Background 2", "Background 1", "Background 7"],
              author: "Logo 10"),
    ]
