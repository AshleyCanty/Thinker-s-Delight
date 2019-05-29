//
//  HighScoresVC+API+Handlers.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/27/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit
import Firebase

// MARK: - Fetch Results and Sort

extension HighScoresViewControlller {
    
    func fetchHighScores() {
        let levels = ["easy", "medium", "hard"]
        setupSpinner()
        
        levels.forEach { (level) in
            getScores(level) { (success) in
                self.sortScores("easy", self.easyScores)
                self.sortScores("medium", self.mediumScores)
                self.sortScores("hard", self.hardScores)
                self.removeSpinner()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func getScores(_ level: String, completion: @escaping ((_ success: Bool)->())) {
        let childName = "\(level) scores"
        Database.database().reference().child(childName).observe(.value) { (snapshot) in
            if let dictionary = snapshot.value as? [String:Any] {
                for (k,v) in dictionary {
                    if let value = v as? [String:Any] {
                        if let nested = value["result"] as? [String:Any] {
                            
                            let average = nested["average"] as! String
                            let date = nested["date"] as! String
                            let score = nested["score"] as! String
                            let username = nested["username"] as! String
                            
                            var photoUrl  = ""
                            if let str = nested["photoURL"] as? String {
                                photoUrl = str
                            } else {
                                photoUrl = ""
                            }

                            let object = Result(average: average, date: date, photoURL: photoUrl, score: score, username: username)

                            if level == "easy" {
                                self.easyScores.append(object)
                            }
                            if level == "medium" {
                                self.mediumScores.append(object)
                            }
                            if level == "hard" {
                                self.hardScores.append(object)
                            }
                        }
                    }
                }
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func sortScores(_ level: String,_ list: [Result]) {
        var scores: [Int] = []
        var sortedList: [Result] = []
        list.forEach { (item) in
            if let stringScore = item.score {
                if let integerScore = Int(stringScore) {
                    scores.append(integerScore)
                }
            }
        }
        
        scores = sortAndRemoveDuplicatesScores(scores)

        scores.forEach { (i) in
            list.forEach({ (item) in
                guard let score = item.score else { return }
                let intScore = Int(score)
                if i == intScore {
                    sortedList.append(item)
                }
            })
        }
        
        if level == "easy" {
            self.easyScores = sortedList
        }
        if level == "medium" {
            self.mediumScores = sortedList
        }
        if level == "hard" {
            self.hardScores = sortedList
        }
    }
    
    func sortAndRemoveDuplicatesScores(_ keyList: [Int]) -> [Int] {
        var list = Array(Set(keyList))
        list.sort { ($0 > $1) }
        return list
    }
}
