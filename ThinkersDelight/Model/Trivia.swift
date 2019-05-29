//
//  TriviaModel.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/17/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

struct TriviaResponse: Codable {
    let response_code: Int?
    let results: [Trivia?]
}

struct Trivia: Codable {
    let category: String?
    let type: String?
    let difficulty: String?
    let question: String?
    let correct_answer: String?
    let incorrect_answers: [String]?

    enum CodingKeys: String, CodingKey {
        case category = "category"
        case type = "type"
        case difficulty = "difficulty"
        case question = "question"
        case correct_answer = "correct_answer"
        case incorrect_answers = "incorrect_answers"
    }
}

