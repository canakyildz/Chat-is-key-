//
//  AuthService.swift
//  Chat is key!
//
//  Created by Apple on 18.03.2020.
//  Copyright © 2020 PHYSID. All rights reserved.
//

import Firebase
import UIKit

struct RegistrationCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService() //we only wanna create one service of this service.Technically you don't have to but it's best practise.
    
    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
                   
        
        
    }
    
    func createUser(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?) {
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return} //compression makes things work faster and for small images it's very usefull.if it was like a instagram post you would wanna compress it less.
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { (meta, error) in
            if let error = error {
                print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
                completion!(error)
                return
            }
            //now we gotta get download url
            ref.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                    if let error = error {
                        print("DEBUG: Failed to create User with error \(error.localizedDescription)")
                        completion!(error)
                        return
                    }
                    //we need to get a user id. that is result we ask from firebase upstairs in completion block.
                    guard let uid = result?.user.uid else { return }
                 
                    //DATABASE data
                    let data = ["email": credentials.email,
                                "fullname": credentials.fullname,
                                "profileImageUrl": profileImageUrl,
                                "uid": uid,
                                "username": credentials.username] as [String: Any]
                    
                    //this is basically going database.database().create a group.child(uid).setvalue(data)
                    
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                    print("created user succesfully")
                    
                    
                    
                }
            }
        }
    }
}
