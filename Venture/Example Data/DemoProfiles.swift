//
//  DemoProfiles.swift
//  Venture
//
//  Created by Lawrence Liu on 1/17/24.
//

import SwiftUI

var profiles = [

    ProfileModel(
        first_name: "Lawrence",
        last_name: "Liu",
        username: "liulawrence45",
        gender: "he/him",
        school: "Stanford University",
        occupation: "BioE @ SMC",
        profileDescription: "Adventurer of all types",
        numPosts: 6,
        numFriends: 180,
        posts: lawrencePosts, //just linked for viewing sake
        bucketList: [    "a late night out at UCSC",
                         "romantic walk at the palace of fine arts :D",
                         "watching the stars @ night on the beach"],
        
        downToGo: lawrencePosts),
    
    
    ProfileModel(
        first_name: "Katie",
        last_name: "Cheng",
        username: "kcheng05",
        gender: "she/her",
        school: "Stanford University",
        occupation: "Research @ SIEPR",
        profileDescription: "Californian at heart",
        numPosts: 1,
        numFriends: 200,
        posts: lawrencePosts, //just linked for conciseness
        bucketList: [    "Chinatown in SF",
                         "Bingsu Date Night",
                         "Twin Peaks @ Midnight"],
        
        downToGo: lawrencePosts)
    
    
        
    
    
        
    

]
