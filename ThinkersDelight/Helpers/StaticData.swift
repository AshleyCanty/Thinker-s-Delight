//
//  StaticData.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/20/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit


enum UserDefaultKeys: String {
    case Category = "Category"
    case Difficulty = "Difficulty"
    case Count = "Count"
}

enum Categories: String {
    case Sports = "21"
    case General = "9"
    case Movies = "11"
    case VideoGames = "15"
}

enum Levels: String {
    case EasyDifficulty = "easy"
    case MediumDifficulty = "medium"
    case HardDifficulty = "hard"
}

enum QuestionAmount: String {
    case Five = "5"
    case Ten = "10"
    case Fifteen = "15"
    case Twenty = "20"
}

enum StoryboardSegues: String {
    case Login = "login"
    case LoginToHome = "loginToHome"
    case resetPassword = "resetPassword"
    case Guest = "guest"
    case SignUp = "signup"
    case SignupToHome = "signupToHome"
    case HowToPlay = "howToPlay"
    case HighScores = "highScores"
    case GameCategory = "gameCategory"
    case GameDifficulty = "gameDifficulty"
    case GameCount = "gameCount"
    case GameStart = "gameStart"
    case GameComplete = "gameCompletion"
}

class Colors {
    static let darkBlue = UIColor(red: 16/255, green: 69/255, blue: 85/255, alpha: 1.0)
    static let lightGreen = UIColor(red: 204/255, green: 174/255, blue: 37/255, alpha: 1.0)
    
    static let yellow = UIColor(red: 242/255, green: 201/255, blue: 60/255, alpha: 1.0)
    static let brightGold = UIColor(red: 255/255, green: 220/255, blue: 115/255, alpha: 1.0)
    static let bronze = UIColor(red: 255/255, green: 191/255, blue: 0/255, alpha: 1.0)
}

class GuestNames {
   static var names = ["Papa Smurf", "Beetle King", "3d Waffle", "Horus", "Lord Marshmallow", "Rose Glyph", "Hawk Dog", "Scoody Boo", "Scorpion", "Coffee Pup", "Bowsky", "DoodleBop", "SnowBlazer", "Queen Woof", "Truman Snout"]
}
