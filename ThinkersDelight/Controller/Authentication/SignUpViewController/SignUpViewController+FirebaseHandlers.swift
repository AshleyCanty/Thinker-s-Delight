//
//  SignUpViewController+FirebaseHandlers.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/23/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


// MARK: - Firebase Handlers

extension SignUpViewController {
    
    func authenticateUserInFirebaseDB(_ email: String,_ username: String,_ password: String,_ image: UIImage) {
        print("Authenticating User...")
        Auth.auth().createUser(withEmail: email, password: password) { (user, err) in
            if err == nil && user != nil {
                print("User created!")
                
                self.uploadProfileImage(image) { (url) in
                    self.updateLabel.text =  "Authenticating..."
                    if url != nil {
                        
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = username
                        changeRequest?.photoURL = url
                        
                        
                        changeRequest?.commitChanges { (err) in
                            if err == nil {
                                print("User display name has changed")
                                
                                self.saveProfile(username, url!) { success in
                                    if success {
                                        self.updateLabel.text = "Successful Sign-up!"
                                        
                                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.5, execute: {
                                            self.removeSpinner()
                                            self.pushToHomescreenVC()
                                        })
                                    }
                                }
                            } else {
                                print("Error: \(err?.localizedDescription)")
                                self.removeAlertsFromTextFields()
                                self.removeWarningLabel()
                            }
                        }
                    } else {
                        print("Failed to upload image")
                    }
                }

            } else {
                print("Error: \(err!.localizedDescription)")
                DispatchQueue.main.async {
                    self.removeSpinner()
                }
                self.presentAuthenticationAlert()
            }
            self.removeAlertsFromTextFields()
            self.removeWarningLabel()
        }
    }
    
    func saveProfile(_ username: String,_ profileImageURL: URL, completion: @escaping ((_ success: Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "username": username,
            "photoURL": profileImageURL.absoluteString
            ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }
    
    func uploadProfileImage(_ image: UIImage, completion: @escaping (_ url: URL?)->()) {
        
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("_images").child("\(imageName).jpg")
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
 
        storageRef.putData(imageData, metadata: metaData) { (metaData, err) in
            if err != nil {
                print(err?.localizedDescription)
                print("Failed to upload image")
                return
            }
            
            // Success
            print("Successfully uploaded image")
            storageRef.downloadURL(completion: { (url, err) in
                if err == nil {
                    completion(url)
                } else {
                    completion(nil)
                }
            })
        }
    }
}

