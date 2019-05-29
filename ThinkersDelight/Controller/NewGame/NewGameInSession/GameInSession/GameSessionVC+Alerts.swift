//
//  GameSession+Alerts.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/23/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

// MARK: - UIAlerts

extension GameSessionVC {
    
    func presentRemainingAttemptsAlert() {
        let alert = UIAlertController(title: "No Attempts Left", message: "You have used all 3 attempts. We will continue to the next question.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: {(_) in
            self.endTimer()
            self.checkForCompletionOfQuiz()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func presentSkipAlert() {
        let alert = UIAlertController(title: "Are you sure?", message: "You will not recieve any points for this question.", preferredStyle: .alert)
        let skip = UIAlertAction(title: "Skip", style: .default, handler: {(_) in
            self.checkForCompletionOfQuiz()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_) in
            self.startTimer()
        })
        alert.addAction(skip)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func presentCorrectAnswerAlert() {
        let alert = UIAlertController(title: "CORRECT!", message: "You earned \(state.currentQuestionPoints) points!", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default, handler: {(_) in
            self.checkForCompletionOfQuiz()
        })
        
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
    }
    
    func presentQuizCompletedAlert() {
        let alert = UIAlertController(title: "Quiz Complete!", message: "You've completed the quiz. Let's check the results.", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default, handler: {(_) in
            self.gotoCompletionScreen()
        })
        
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
    }
}
