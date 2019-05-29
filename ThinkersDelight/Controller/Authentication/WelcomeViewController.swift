//
//  ViewController.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/16/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var textFieldsStackView: UIStackView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(verifyUserLoggedOut), name: NSNotification.Name("verifyLogout"), object: nil)
        
        if Auth.auth().currentUser != nil {
            print("Still logged in")
            pushToHome(animated: false)
        }
    }

    @IBAction func guestButtonDidTap() {
        pushToHome(animated: true)
    }
    
    func pushToHome(animated: Bool) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomescreenViewController
        self.navigationController?.pushViewController(vc, animated: animated)
    }

    @objc func verifyUserLoggedOut() {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: textFieldsStackView.bounds.width, height: 30))
        messageLabel.text = "Successfully Logged out!"
        messageLabel.textColor = .white
        messageLabel.font = .boldSystemFont(ofSize: 14)
        messageLabel.textAlignment = .center
//        textFieldsStackView.addArrangedSubview(messageLabel)
        textFieldsStackView.insertArrangedSubview(messageLabel, at: 0)
        
        UIView.animate(withDuration: 1.5, delay: 1.4, options: [], animations: {
            messageLabel.alpha = 0
        }) { (true) in
            messageLabel.removeFromSuperview()
        }
    }
}

