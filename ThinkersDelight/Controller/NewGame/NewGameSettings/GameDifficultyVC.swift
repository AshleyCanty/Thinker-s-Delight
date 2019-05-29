//
//  CategoryCell.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/20/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

class GameDifficultyVC: UIViewController {
    
    @IBAction func easyButtonDidTap(_ sender: UIButton) {
        UserDefaults.standard.set(Levels.EasyDifficulty.rawValue, forKey: UserDefaultKeys.Difficulty.rawValue)
        performSegue(withIdentifier: StoryboardSegues.GameCount.rawValue, sender: nil)
    }
    
    @IBAction func mediumButtonDidTap(_ sender: UIButton) {
        UserDefaults.standard.set(Levels.MediumDifficulty.rawValue, forKey: UserDefaultKeys.Difficulty.rawValue)
        performSegue(withIdentifier: StoryboardSegues.GameCount.rawValue, sender: nil)
    }
    
    @IBAction func hardButtonDidTap(_ sender: UIButton) {
        UserDefaults.standard.set(Levels.HardDifficulty.rawValue, forKey: UserDefaultKeys.Difficulty.rawValue)
        performSegue(withIdentifier: StoryboardSegues.GameCount.rawValue, sender: nil)
    }
}
