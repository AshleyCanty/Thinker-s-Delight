//
//  ScoreTableCell.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/20/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

class ScoreTableCell: UITableViewCell {
    
    @IBOutlet weak var placeNumberLabel: UILabel!
    @IBOutlet weak var totalScore: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    var scoreObject: Result? {
        didSet {
            setupUI()
        }
    }

    override func awakeFromNib() {
        profileImage.layer.cornerRadius = profileImage.bounds.width/2
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
    }
    
    
    func setupUI() {
        if let object = scoreObject {
            
            if let url = object.photoURL {
                profileImage.loadImageUsingCacheWithUrlString(url)
            } 
            
            totalScore.text = object.score
            username.text = object.username
            
            totalScore.textColor = .green
            username.textColor = .white
        } else {
            totalScore.text = "0000"
            profileImage.image = UIImage(named: "user-image")
            username.text = "N/A"
            
            totalScore.textColor = UIColor.white.withAlphaComponent(0.50)
            username.textColor = UIColor.white.withAlphaComponent(0.50)
        }
    }
}
