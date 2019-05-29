//
//  GameDoneVC+API+Handlers.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/28/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit
import Firebase

// MARK: - Save Score to FirebasDB

extension GameDoneVC {
    
    func postFinalScoreInFirebaseDB() {
        guard let level = state?.level else { return }
        guard let score = scoreNumberLabel.text else { return }
        guard let average = percentageLabel.text else { return }
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyy"
        let dateString = formatter.string(from:date)
        
        let values: [String: Any] = ["score":score, "average": average, "date": dateString]
        let generalScoreValues: [String: Any] = ["username": self.username as Any, "photoURL": self.photoURL as Any, "score": score, "average": average, "date": dateString]
        
        if Auth.auth().currentUser?.uid != nil {
            updateUserProfileWithScore(level, values) { (success) in
                if success {
                    self.updateGeneralScoreList(level, generalScoreValues, completion: { (success) in
                        if success {
                            print("Saved to general Score List")
                        } else {
                            print("Failed to save to general Score List")
                        }
                    })
                } else {
                    self.presentErrorSavingScoreAlert()
                    print("Error saving results to profile in database")
                }
            }
        } else {
            updateGeneralScoreList(level, generalScoreValues) { (success) in
                if success {
                    print("Saved to general Score List")
                } else {
                    self.presentErrorSavingScoreAlert()
                    print("FAiled to Save to general Score List")
                }
            }
        }
    }
    
    
    func updateGeneralScoreList(_ level: String, _ values: [String: Any], completion: @escaping ((_ success: Bool)->())) {
        let databaseRef = Database.database().reference().child("\(level) scores").childByAutoId().child("result").setValue(values) { (err, ref) in
            if err == nil {
                print("Successs")
            } else {
                print("Error: \(err?.localizedDescription)")
            }
            completion(err==nil)
        }
    }
    
    func updateUserProfileWithScore(_ level: String, _ values: [String: Any], completion: @escaping ((_ success: Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)").child("scores").child("\(level)")
        
        databaseRef.childByAutoId().child("result").setValue(values) { (err, ref) in
            if err == nil {
                print("Successs")
            } else {
                print("Error: \(err?.localizedDescription)")
            }
            completion(err==nil)
        }
    }
}
