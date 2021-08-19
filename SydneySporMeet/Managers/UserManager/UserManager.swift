//
//  UserManager.swift
//  SydneySporMeet
//
//  Created by Nikesh Shakya on 4/13/19.
//  Copyright © 2019 Niroj Thapa. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit
import GoogleSignIn

class UserManager {
    
    var currentUser: User? {
        get {
            if let usrBaseData = (UserDefaults.standard.object(forKey: AppUserDefaultKeys.sessionUser.rawValue) as? Data) {
                do {
                    let user = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(usrBaseData) as? User
                    return user
                }
                catch {
                    return nil
                }
            }
            return nil
        }
    }
    
    func getUserDetails(byId id: String, completion: @escaping responseBlock) {
        let userDB = Firestore.firestore().collection(DBCollectionKeys.users.rawValue)
        userDB.document(id).getDocument { (snapshotData, error) in
            if let err = error {
                completion(nil, err)
            }
            else if let snapshot = snapshotData, snapshot.exists, let userDict = snapshot.data(){
                let user = self.mapUserDictIntoUserObject(dict: userDict)
                user.id = id
                completion(user, nil)
            }
            else {
                completion(nil, nil)
            }
        }
    }
    
    func mapUserDictIntoUserObject(dict: [String: Any]) -> User {
        let user = User()
        user.emailAddress = dict[DBFieldKeys.users.email.rawValue] as? String
        user.name = dict[DBFieldKeys.users.name.rawValue] as? String
        user.phoneNumber = dict[DBFieldKeys.users.phone.rawValue] as? String
        user.postalCode = dict[DBFieldKeys.users.postalCode.rawValue] as? Int
        user.locationForExercise = dict[DBFieldKeys.users.locationForExercise.rawValue] as? String
        user.state = dict[DBFieldKeys.users.state.rawValue] as? String
        user.interestedIn = dict[DBFieldKeys.users.interestedIn.rawValue] as? [String]
        return user
    }
    
    func updateUserDataIntoFireStore(id: String, editedUser: User? = nil, userData: [String: Any], completion: @escaping responseBlock) {
        let userDB = Firestore.firestore().collection(DBCollectionKeys.users.rawValue)
        userDB.document(id).updateData(userData) { (error) in
            if let err = error {
                completion(false, err)
                return
            }
            else {
                if let userEdited = editedUser {
                    self.storeUserIntoUserDefaults(user: userEdited, completion: completion)
                }
                else {
                    completion(true, nil)
                    return
                }
            }
        }
    }
    
    func uploadUserProfilePicture(image: UIImage, id: String, completion: @escaping responseBlock) {
        let storageRef = Storage.storage().reference().child("users/\(id)").child("profile_pic.jpg")
        guard let data = image.jpegData(compressionQuality: 0.3) else {
            completion(false, nil)
            return
        }
        storageRef.putData(data, metadata: nil) { (metadata, err) in
            if let error = err {
                completion(false, error)
            }
            else if let _ = metadata {
                storageRef.downloadURL(completion: { (url, err) in
                    if let downloadlink = url {
                        let data = [DBFieldKeys.users.propic.rawValue: downloadlink.absoluteString]
                        self.updateUserDataIntoFireStore(id: id, userData: data, completion: {
                            (data, err) in
                            if let error = err {
                                completion(nil, error)
                            }
                            else {
                                completion(downloadlink.absoluteString, nil)
                            }
                        })
                    }
                    else {
                        completion(false, err)
                    }
                })
            }
            else {
                completion(false, nil)
            }
        }
    }
    
    func storeUserIntoFirestore(id: String, userData: [String: Any], completion: @escaping responseBlock) {
        let userDB = Firestore.firestore().collection(DBCollectionKeys.users.rawValue)
        userDB.document(id).setData(userData) { (error) in
            if let err = error {
                completion(nil, err)
            }
            else {
                completion(true, nil)
            }
        }
    }
    
    func storeUserIntoUserDefaults(user: User, completion: @escaping responseBlock) {
        do {
            let archUser = try NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false)
            UserDefaults.standard.set(archUser, forKey: AppUserDefaultKeys.sessionUser.rawValue)
            completion(true, nil)
        }
        catch {
            completion(false, nil)
        }
    }
    
    func signout(completion: @escaping responseBlock) {
        do {
            guard let signedInUser = self.currentUser else {
                completion(false, nil)
                return
            }
            try Auth.auth().signOut()
            FBSDKLoginManager().logOut()
            GIDSignIn.sharedInstance()?.signOut()
            UserDefaults.standard.removeObject(forKey: AppUserDefaultKeys.sessionUser.rawValue)
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
            UserManager().updateUserDataIntoFireStore(id: signedInUser.id!, userData: [DBFieldKeys.users.fcmToken.rawValue: FieldValue.delete()], completion: {
                (_, _) in
            })
            completion(true, nil)
        }
        catch {
            completion(false, error)
        }
    }
}
