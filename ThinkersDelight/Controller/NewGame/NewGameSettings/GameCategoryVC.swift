//
//  GameOptionsTableViewController.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/18/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

class GameCategoryVC: UIViewController{
    
    @IBAction func sportsButtonDidTap(_ sender: UIButton) {
        UserDefaults.standard.set(Categories.Sports.rawValue, forKey: UserDefaultKeys.Category.rawValue)
        performSegue(withIdentifier: StoryboardSegues.GameDifficulty.rawValue, sender: nil)
    }
    
    @IBAction func animalsButtonDidTap(_ sender: UIButton) {
        UserDefaults.standard.set(Categories.General.rawValue, forKey: UserDefaultKeys.Category.rawValue)
        performSegue(withIdentifier: StoryboardSegues.GameDifficulty.rawValue, sender: nil)
    }
    
    @IBAction func moviesButtonDidTap(_ sender: UIButton) {
        UserDefaults.standard.set(Categories.Movies.rawValue, forKey: UserDefaultKeys.Category.rawValue)
        performSegue(withIdentifier: StoryboardSegues.GameDifficulty.rawValue, sender: nil)
    }
    
    @IBAction func videogamesButtonDidTap(_ sender: UIButton) {
        UserDefaults.standard.set(Categories.VideoGames.rawValue, forKey: UserDefaultKeys.Category.rawValue)
        performSegue(withIdentifier: StoryboardSegues.GameDifficulty.rawValue, sender: nil)
    }
}
