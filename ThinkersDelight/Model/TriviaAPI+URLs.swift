//
//  TriviaAPI.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/17/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

enum TriviaURLs: String {
    case baseURL = "https://opentdb.com/api.php?"
    case RequestToken = "https://opentdb.com/api_token.php?command=request"
    case ResetToke = "https://opentdb.com/api_token.php?command=reset&token=YOURTOKENHERE"
    case AnyEasyQuestions = "https://opentdb.com/api.php?amount=10&difficulty=easy&type=multiple"
    case AnyMediumQuestions = "https://opentdb.com/api.php?amount=10&difficulty=medium&type=multiple"
    case AnyHardQuestions = "https://opentdb.com/api.php?amount=10&difficulty=hard&type=multiple"
    case VideogameEasyQuestions = "https://opentdb.com/api.php?amount=10&category=15&difficulty=easy&type=multiple"
    case VideogameMediumQuestions = "https://opentdb.com/api.php?amount=10&category=15&difficulty=medium&type=multiple"
    case VideogameHardQuestions = "https://opentdb.com/api.php?amount=10&category=15&difficulty=hard&type=multiple"
    case SportsEasyQuestions = "https://opentdb.com/api.php?amount=10&category=21&difficulty=easy&type=multiple"
    case SportsMediumQuestions = "https://opentdb.com/api.php?amount=10&category=21&difficulty=medium&type=multiple"
    case SportsHardQuestions = "https://opentdb.com/api.php?amount=10&category=21&difficulty=hard&type=multiple"
    case MoviesEasyQuestions = "https://opentdb.com/api.php?amount=10&category=11&difficulty=easy&type=multiple"
    case MoviesMediumQuestions = "https://opentdb.com/api.php?amount=10&category=11&difficulty=medium&type=multiple"
    case MoviesHardQuestions = "https://opentdb.com/api.php?amount=10&category=11&difficulty=hard&type=multiple"
    case AnimalsEasyQuestions = "https://opentdb.com/api.php?amount=10&category=27&difficulty=easy&type=multiple"
    case AnimalsMediumQuestions = "https://opentdb.com/api.php?amount=10&category=27&difficulty=medium&type=multiple"
    case AnimalsHardQuestions = "https://opentdb.com/api.php?amount=10&category=27&difficulty=hard&type=multiple"
}
