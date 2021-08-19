//
//  KeyConstants.swift
//  SydneySporMeet
//
//  Created by Nikesh Shakya on 4/13/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import Foundation

typealias responseBlock = ((Any?, Error?) -> Void)

enum AppUserDefaultKeys: String {
    case sessionUser = "loggedInUser"
}

enum DBCollectionKeys: String {
    case users = "users"
}

var sports = ["Cycling","Football","Golf"]
var states = ["NSW","ACT","VIC","NT","TAS"]

struct DBFieldKeys {
    enum users: String {
        case propic = "picture_url"
        case email = "email"
        case phone = "phone"
        case name = "name"
        case postalCode = "post_code"
        case fcmToken = "fcm_token"
        case locationForExercise = "location_for_exercise"
        case state = "state"
        case interestedIn = "interested_in"
    }
    
}
