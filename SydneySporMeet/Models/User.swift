//
//  User.swift
//  SydneySporMeet
//
//  Created by Niroj Thapa on 4/9/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding{
    var id: String?
    var name: String?
    var fcmToken: String?
    var emailAddress : String?
    var phoneNumber : String?
    var postalCode: Int?
    var locationForExercise: String?
    var state: String?
    var interestedIn : [String]?
    
    init(name: String?,emailAddress:String,phoneNumber:String,postalCode:Int,locationForExercise:String,
         state:String,interestedIn:[String]) {
        self.name = name
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
        self.postalCode = postalCode
        self.state = state
        self.locationForExercise = locationForExercise
        self.interestedIn = interestedIn
        
    }
    
    override init() {
        super.init()
        self.id = nil
        self.name = nil
        self.emailAddress = nil
        self.phoneNumber = nil
        self.postalCode = nil
        self.locationForExercise = nil
        self.state = nil
        self.interestedIn = nil
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id,forKey:"id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(fcmToken, forKey: "fcmToken")
        aCoder.encode(emailAddress,forKey:"email")
        aCoder.encode(phoneNumber,forKey:"phone")
        aCoder.encode(postalCode, forKey: "postCode")
        aCoder.encode(locationForExercise, forKey: "locationForExercise")
        aCoder.encode(state,forKey:"state")
        aCoder.encode(interestedIn,forKey:"interests")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.id = aDecoder.decodeObject(forKey: "id") as? String
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.emailAddress = aDecoder.decodeObject(forKey:"email") as? String
        self.phoneNumber = aDecoder.decodeObject(forKey:"phone") as? String
        self.postalCode = aDecoder.decodeObject(forKey: "postCode") as? Int
        self.locationForExercise = aDecoder.decodeObject(forKey: "locationForExercise") as? String
        self.state = aDecoder.decodeObject(forKey: "state") as? String
        self.interestedIn =  aDecoder.decodeObject(forKey:"interests") as? [String]
        self.fcmToken =  aDecoder.decodeObject(forKey:"fcmToken") as? String
    }
}

class AuthUser {
    var email: String?
    var fullname: String?
    var password: String?
    var isValid: Bool {
        return email != nil && password != nil
    }
    
    init() {
        self.email = ""
        self.fullname = ""
        self.password = ""
    }
    
    func toUser() -> User {
        let user = User()
        user.emailAddress = self.email
        user.name = self.fullname
        user.phoneNumber = ""
        user.postalCode = 0
        user.locationForExercise = ""
        user.state = ""
        user.interestedIn = nil
        return user
    }
    
    func toSignupJSON() -> [String: Any] {
        var jsonObject = [String: Any]()
        jsonObject[DBFieldKeys.users.email.rawValue] = self.email
        jsonObject[DBFieldKeys.users.name.rawValue] = self.fullname
        jsonObject[DBFieldKeys.users.phone.rawValue] = ""
        jsonObject[DBFieldKeys.users.postalCode.rawValue] = 0
        jsonObject[DBFieldKeys.users.locationForExercise.rawValue] = ""
        jsonObject[DBFieldKeys.users.state.rawValue] = ""
        jsonObject[DBFieldKeys.users.interestedIn.rawValue] = ""
        return jsonObject
    }
}
