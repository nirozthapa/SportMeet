//
//  UserSignupManager.swift
//  SydneySporMeet
//
//  Created by Nikesh Shakya on 4/13/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class SignupManager {
    
    func storeSignedUpUserIntoUserDefaults(id: String, user: AuthUser, completion: @escaping responseBlock) {
        let userToSave = user.toUser()
        InstanceID.instanceID().instanceID(handler: { (result, err) in
            if let fcmToken = result?.token {
                userToSave.fcmToken = fcmToken
                UserManager().updateUserDataIntoFireStore(id: id, userData: [DBFieldKeys.users.fcmToken.rawValue: fcmToken], completion: { (data, err) in
                    if let error = err {
                        completion(nil, error)
                    }
                    else {
                        do {
                            let archUser = try NSKeyedArchiver.archivedData(withRootObject: userToSave, requiringSecureCoding: false)
                            UserDefaults.standard.set(archUser, forKey: AppUserDefaultKeys.sessionUser.rawValue)
                            completion(true, nil)
                        }
                        catch {
                            completion(false, nil)
                        }
                    }
                })
            }
            else {
                debugPrint("Error in retrieving token")
                completion(nil, err)
            }
        })
        
    }
    
    func storeUserIntoFirestore(user: AuthUser, completion: @escaping responseBlock) {
        let userDB = Firestore.firestore().collection(DBCollectionKeys.users.rawValue)
        let newId = userDB.document().documentID
        userDB.document(newId).setData(user.toSignupJSON()) { (error) in
            if let err = error {
                completion(nil, err)
            }
            else {
                self.storeSignedUpUserIntoUserDefaults(id: newId, user: user, completion: completion)
            }
        }
    }
    
    func signupUser(user: AuthUser, completion: @escaping responseBlock) {
        guard user.isValid else {
            completion(nil, nil)
            return
        }
        Auth.auth().createUser(withEmail: user.email!, password: user.password!) { (data, error) in
            if let err = error {
                debugPrint("Error creating user with error: \(err.localizedDescription)")
                completion(nil, err)
            }
            else {
                if let createdUser = data?.user, user.email == createdUser.email  {
                    self.storeUserIntoFirestore(user: user, completion: completion)
                }
                else {
                    completion(nil, nil)
                }
            }
        }
    }
}
