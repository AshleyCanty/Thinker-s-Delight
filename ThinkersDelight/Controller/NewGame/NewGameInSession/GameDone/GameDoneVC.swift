//
//  GameDoneVC.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/21/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit
import SAConfettiView
import Firebase

class GameDoneVC: UIViewController {
    
    @IBOutlet weak var scoreNumberLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var finalStatementLabel: UILabel!
    @IBOutlet weak var returnHomeButton: UIButton!
    
    var user: User?
    var state: GameState?
    var triviaCount = 0
    var username: String?
    var photoURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        username = UserDefaults.standard.string(forKey: "username")
        photoURL = UserDefaults.standard.string(forKey: "photoURL")
        navigationItem.hidesBackButton = true
        
        postFinalScoreInFirebaseDB()
    }
    
    @IBAction func returnHomeButtonDidTap() {
        for vc in (self.navigationController?.viewControllers ?? []) {
            if vc is HomescreenViewController {
                _ = self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
    func setupConfetti(){
        let confettiView = SAConfettiView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        confettiView.type = .Diamond
        confettiView.startConfetti()
        view.addSubview(confettiView)
        view.bringSubviewToFront(returnHomeButton)
        
    }
    
    func setupViews() {
        if let state =  state {
            scoreNumberLabel.text = String(state.totalPoints)
            
            let correctPercent = (Double(state.correctAnswers)/Double(triviaCount))*100
            let rounded = String(format: "%.2f", correctPercent)
            percentageLabel.text = "\(String(rounded))%"
            
            if correctPercent > 70.00 {
                setupConfetti()
                percentageLabel.textColor = .green
                finalStatementLabel.text = "Congratulations! You answered \(state.correctAnswers) questions out of \(triviaCount) correctly."
            } else {
                percentageLabel.textColor = .white
                finalStatementLabel.text = "You answered \(state.correctAnswers) questions out of \(triviaCount) correctly."
            }
        } 
    }
    
    func presentErrorSavingScoreAlert() {
        let alert = UIAlertController(title: "Error Saving Data", message: "We apologize. There was an error processing your information.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

