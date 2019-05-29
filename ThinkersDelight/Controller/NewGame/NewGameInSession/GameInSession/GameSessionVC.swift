//
//  GameSessionTableVC.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/20/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

class GameSessionVC: UIViewController {
    
    @IBOutlet weak var leftSideMenuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var markerImageA: UIImageView!
    @IBOutlet weak var markerImageB: UIImageView!
    @IBOutlet weak var markerImageC: UIImageView!
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    let userDefaults = UserDefaults.standard
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    var spinnerContainer: UIView?
    var triviaList: [Trivia]?
    var currentTriviaIndex = 0
    var currentAnswers = [String]()
    var selectedAnswer = ""
    var countdownTimer: Timer!
    var totalTime = 30
    var state = GameState()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialData()
        self.navigationItem.leftBarButtonItem = leftSideMenuButton
        tableView.layer.cornerRadius = 8
        
        NotificationCenter.default.addObserver(self, selector: #selector(startTimer), name: NSNotification.Name(rawValue: "StartTimer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(endTimer), name: NSNotification.Name(rawValue: "StopTimer"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UserDefaults.standard.set(true, forKey: "InSession")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UserDefaults.standard.set(false, forKey: "InSession")
    }
    
    
    @IBAction func onMoreTapped() {
        NotificationCenter.default.post(name: Notification.Name("ToggleSideMenu"), object: nil)
    }
    
    @IBAction func submitButtonDidTap() {
        updateGameState()
    }
    
    @IBAction func skipButtonDidTap() {
        endTimer()
        presentSkipAlert()
    }
    
    func setupSpinner() {
        spinnerContainer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        spinnerContainer?.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        spinnerContainer?.addSubview(spinner)
        spinner.center = spinnerContainer!.center
        DispatchQueue.main.async {
            self.spinner.startAnimating()
            self.view.addSubview(self.spinnerContainer!)
        }
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.spinnerContainer?.removeFromSuperview()
        }
    }
    
    func setupInitialData() {
        questionLabel.text = " "
        totalScoreLabel.text = "0"
        state.setDifficulty()
        fetchQuestionAndAnswers()
    }
    
    func updateMarkerImages() {
        if state.remainingAttempts == 2 {
            markerImageA.image = UIImage(named: "cancel-mark")
        }
        if state.remainingAttempts == 1 {
            markerImageB.image = UIImage(named: "cancel-mark")
        }
        if state.remainingAttempts == 0 {
            markerImageC.image = UIImage(named: "cancel-mark")
        }
    }
    
    func resetMarkerImages() {
        markerImageA.image = UIImage(named: "empty-mark")
        markerImageB.image = UIImage(named: "empty-mark")
        markerImageC.image = UIImage(named: "empty-mark")
    }
    
    func resetUnselectedRowColors(indexPath: IndexPath) {
        let cellCount = tableView.numberOfRows(inSection: 0)
        
        for i in 0..<cellCount {
            if i != indexPath.row {
                let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! AnswerCell
                cell.backgroundColor = Colors.darkBlue
                cell.answerLabel.textColor = UIColor.white
                cell.placeNumberLabel.textColor = UIColor.white
                
            }
        }
    }
    
    // MARK: - Navigation
    
    func gotoCompletionScreen() {
        performSegue(withIdentifier: StoryboardSegues.GameComplete.rawValue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryboardSegues.GameComplete.rawValue {
            if let vc = segue.destination as? GameDoneVC {
                vc.triviaCount = triviaList!.count
                vc.state = state
            }
        }
    }
}




