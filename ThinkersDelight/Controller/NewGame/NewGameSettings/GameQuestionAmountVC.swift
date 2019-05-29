//
//  GameQuestionAmountVC.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/20/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

class GameQuestionAmountVC: UIViewController {
    @IBAction func set5Questions() {
        UserDefaults.standard.set(QuestionAmount.Five.rawValue, forKey: UserDefaultKeys.Count.rawValue)
        performSegue(withIdentifier: StoryboardSegues.GameStart.rawValue, sender: nil)
    }
    
    @IBAction func set10Questions() {
        UserDefaults.standard.set(QuestionAmount.Ten.rawValue, forKey: UserDefaultKeys.Count.rawValue)
        performSegue(withIdentifier: StoryboardSegues.GameStart.rawValue, sender: nil)
    }
    
    @IBAction func set15Questions() {
        UserDefaults.standard.set(QuestionAmount.Fifteen.rawValue, forKey: UserDefaultKeys.Count.rawValue)
        performSegue(withIdentifier: StoryboardSegues.GameStart.rawValue, sender: nil)
    }
    
    @IBAction func set20Questions() {
        UserDefaults.standard.set(QuestionAmount.Twenty.rawValue, forKey: UserDefaultKeys.Count.rawValue)
        performSegue(withIdentifier: StoryboardSegues.GameStart.rawValue, sender: nil)
    }
}
