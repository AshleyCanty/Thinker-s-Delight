//
//  GameSession+TimerHandlers.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/23/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

// MARK: - Timer Functions

extension GameSessionVC {
    @objc func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        countdownTimer.fire()
    }
    
    @objc func updateTime() {
        timerLabel.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            if totalTime == 15 {
                timerLabel.textColor = .red
            }
            state.updateRemainingTime(seconds: totalTime)
            totalTime -= 1
            
        } else {
            endTimer()
            timeExpiredAlert()
        }
    }
    
    func resetTimeLabel() {
        totalTime = 30
        timerLabel.textColor = .darkGray
    }
    
    func timeExpiredAlert() {
        let alert = UIAlertController(title: "Time Expired!", message: "You ran out of time and will recieve no credit for this question.", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Go to Next Question", style: .default, handler: {(_) in
            self.checkForCompletionOfQuiz()
        })
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
