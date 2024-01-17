//
//  DemoProfiles.swift
//  Venture
//
//  Created by Lawrence Liu on 1/17/24.
//

import SwiftUI

var profiles = [

    ProfileModel(
        profilePicture: "04B0D33D-83BB-4E23-BE56-50EFA4FB1B7C",
        firstName: "Lawrence",
        lastName: "Liu",
        username: "liulawrence45",
        gender: "he/him",
        school: "Stanford University",
        occupation: "CompBio @ SMC",
        profileDescription: "Lover all of things adventure-wise",
        numFriends: 180,
        posts: lawrencePosts, //just linked for viewing sake
        bucketList: [    "a late night out at UCSC",
                         "romantic walk at the palace of fine arts :D",
                         "watching the stars @ night on the beach"],
        
        downToGo: lawrencePosts),
    
    
    ProfileModel(
        profilePicture: "IMG_5155",
        firstName: "Katie",
        lastName: "Cheng",
        username: "kcheng05",
        gender: "she/her",
        school: "Stanford University",
        occupation: "Research @ SIEPR",
        profileDescription: "Californian at heart",
        numFriends: 200,
        posts: lawrencePosts, //just linked for conciseness
        bucketList: [    "Chinatown in SF",
                         "Bingsu Date Night",
                         "Twin Peaks @ Midnight"],
        
        downToGo: lawrencePosts)
    
    
        
    
    
        
    

]
