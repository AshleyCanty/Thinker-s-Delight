//
//  HighScoresTableViewControlller.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/18/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseFirestore


class HighScoresViewControlller: UIViewController {
    

    @IBOutlet weak var easyScoresButton: UIButton!
    @IBOutlet weak var mediumScoresButton: UIButton!
    @IBOutlet weak var hardScoresButton: UIButton!
    @IBOutlet weak var tableContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    var spinnerContainer: UIView?
    var easyScores: [Result] = []
    var mediumScores: [Result] = []
    var hardScores: [Result] = []
    var currentScorelevel = 0 // 0 = easy; 1 = medium; 2 = hard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHighScores()
        setupUI()
    }
    
    @IBAction func easyScoresButtonDidTap() {
        currentScorelevel = 0
        changeSelectedButton([easyScoresButton, mediumScoresButton, hardScoresButton])
        self.tableView.reloadData()
    }
    
    @IBAction func mediumScoresButtonDidTap() {
        currentScorelevel = 1
        changeSelectedButton([mediumScoresButton, easyScoresButton, hardScoresButton])
        self.tableView.reloadData()
    }
    
    @IBAction func hardScoresButtonDidTap() {
        currentScorelevel = 2
        changeSelectedButton([hardScoresButton,easyScoresButton, mediumScoresButton])
        self.tableView.reloadData()
    }
    
    func changeSelectedButton(_ buttons: [UIButton]) {
        UIView.animate(withDuration: 0.15) {
            buttons[0].backgroundColor = UIColor.white
            buttons[0].setTitleColor(Colors.darkBlue, for: .normal)
            buttons[1].backgroundColor = Colors.darkBlue
            buttons[1].setTitleColor(.white, for: .normal)
            buttons[2].backgroundColor = Colors.darkBlue
            buttons[2].setTitleColor(.white, for: .normal)
        }
    }
    
    func setupUI() {
        tableContainer.layer.cornerRadius = 8
        tableContainer.clipsToBounds = true
        tableView.layer.cornerRadius = 8
        tableView.clipsToBounds = true
        tableView.isScrollEnabled = false
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
}
