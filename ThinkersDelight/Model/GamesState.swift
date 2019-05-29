//
//  GamesState.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/21/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import Foundation

struct GameState {
    var totalPoints = 0
    var currentQuestionPoints = 0
    var remainingTime = 0
    var correctAnswers = 0
    var remainingAttempts = 3
    var level = ""
    
    // MARK: -- Score Calculations
    
    // Called after completion
    func getOverallScore() -> Int {
        return self.totalPoints
    }
    
    // Called inside calculateCurrentQuestionPoints
    func calculatePointsFromRemainingAttempts() -> Int {
        if remainingAttempts == 3 { // correct on 1st try
            return 1500
        } else if remainingAttempts == 2 { // correct on 2nd try
            return 1000
        } else { // correct on 3rd try
            return 500
        }
    }
    // Called inside calculateCurrentQuestionPoints
    func calculatePointsFromRemainingTime() -> Int {
        var pointsFromSecondsLeft = 0
        
        for x in 0..<remainingTime {
            switch x {
            case 21 ... 30:
                pointsFromSecondsLeft += 800
            case 11 ... 20:
                pointsFromSecondsLeft += 400
            case 0 ... 10:
                pointsFromSecondsLeft += 200
            default:
                print()
            }
        }
        return pointsFromSecondsLeft
    }
    
    // Called inside calculateCurrentQuestionPoints
    func calculatePointsForCorrectAnswer() -> Int {
        let level = UserDefaults.standard.string(forKey: UserDefaultKeys.Difficulty.rawValue)
        
        switch level {
        case "easy":
            return 3000
        case "medium":
            return 4000
        case "hard":
            return 5000
        default:
            return 3000
        }
    }
    
    mutating func calculateAllPointsForCurrentQuestion() {
        let timePoints = calculatePointsFromRemainingTime()
        let answerPoints = calculatePointsForCorrectAnswer()
        let attemptPoints = calculatePointsFromRemainingAttempts()
        let newPoints = (timePoints+answerPoints+attemptPoints)
    
        updateCorrectAnswer()
        calculateTotalGamePoints(newPoints: newPoints)
        self.currentQuestionPoints = newPoints
    }
    
    // Called inside calculateCurrentQuestionPoints
    mutating func calculateTotalGamePoints(newPoints: Int) {
        self.totalPoints += newPoints
    }
    
    // MARK: -- Reset & Track: Attempts, Time, and Answers
    
    // Called only when once game starts
    mutating func setDifficulty() {
        let currentlevel = UserDefaults.standard.string(forKey: UserDefaultKeys.Difficulty.rawValue)
        self.level = currentlevel ?? "easy"
    }
    
    // Called when presenting new question
    mutating func resetForNewQuestion() {
        self.remainingTime = 0
        self.remainingAttempts = 3
    }
    
    // Called when answer is correct
    mutating func updateCorrectAnswer() {
        self.correctAnswers += 1
    }
    
    // Called after updateCorrectAnswer
    mutating func updateRemainingTime(seconds: Int) {
        self.remainingTime += seconds
    }

    // Called when answer is incorrect
    mutating func subtractRemainingAttempts() {
        self.remainingAttempts -= 1
    }
    
    // Called after subtractRemainingAttempts
    func checkRemainingAttempts() -> Bool {
        if remainingAttempts == 0 {
            return false
        }
        return true
    }
}
