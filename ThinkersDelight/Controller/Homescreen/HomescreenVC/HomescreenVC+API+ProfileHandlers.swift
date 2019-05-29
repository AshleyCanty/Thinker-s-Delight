//
//  HomescreenVC+ProfileHandlers.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/25/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit
import Firebase



extension HomescreenViewController {
    
    // MARK: - Set Up Profile Username and Photo
    
    func setupUsername() {
        if let username = Auth.auth().currentUser?.displayName {
            welcomeLabel.text = "Welcome, \(username)!"
            user?.username = username
        } else {
            let randomUsername = generateRandomUsername()
            welcomeLabel.text = "Welcome, \(randomUsername)!"
            user?.username = randomUsername
        }
    }
    
    func generateRandomUsername() -> String {
        GuestNames.names.shuffle()
        let n = arc4random_uniform(9642)
        let strNumber = String(n)
        
        if let name = GuestNames.names.first {
            var strName = name
            strName.append(strNumber)
            
            let finalStr = "\(strName)"
            return finalStr
        }
        return "Guest\(strNumber)"
    }
    
    func getProfileImageUrl() {
        guard let uid = Auth.auth().currentUser?.uid else {
            profileImageView.image = UIImage(named: "user-image")
            user?.photoURL = nil
            return
        }
        
        Database.database().reference().child("users").child("profile").child(uid).observe(.value) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.user?.username = Auth.auth().currentUser?.displayName
                let photoURL = (dictionary["photoURL"] as! String)
                
                if photoURL.count > 0 {
                    self.user?.photoURL = photoURL
                    self.profileImageView.loadImageUsingCacheWithUrlString(photoURL)
                } else {
                    self.user?.photoURL = ""
                    self.profileImageView.image = UIImage(named: "user-image")
                }
            }
        }
    }
    
    // MARK: - Update Profile With New Image
    
    func updateProfileWithNewImage() {
        self.uploadProfileImage { (url) in
            if url != nil {
                self.updateProfile(url!) { (success) in
                    print("successfully changed")
                }
            }
        }
    }
    
    func updateProfile(_ url: URL,completion: @escaping((_ success: Bool) -> ())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        databaseRef.updateChildValues(["photoURL" : url.absoluteString]) { (err, ref) in
            completion(err==nil)
        }
    }
    
    func uploadProfileImage(completion: @escaping (_ url: URL?)->()) {
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("_images").child("\(imageName).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        guard let imageData = profileImageView.image?.jpegData(compressionQuality: 0.75) else { return }
        
        storageRef.putData(imageData, metadata: metadata) { (meta, err) in
            if err != nil {
                print("Error: \(err?.localizedDescription)")
                self.presentImageUploadFailedAlert()
            }
            storageRef.downloadURL(completion: { (url, err) in
                if err != nil {
                    print("Error getting DownloadURL")
                    completion(nil)
                } else {
                    print("Success DownloadURL")
                    completion(url)
                }
            })
        }
    }
    
    func presentImageUploadCompleteAlert() {
        let alert = UIAlertController(title: "Successfully Updated Profile", message: "Your image was successfully uploaded and saved.", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
    }
    
    func presentImageUploadFailedAlert() {
        let alert = UIAlertController(title: "Error Uploading Image", message: "There was an error uploading the image. Please try again.", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
    }
}

