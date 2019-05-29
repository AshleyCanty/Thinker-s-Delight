//
//  CreateNewPasswordVC.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/28/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit
import Firebase

class CreateNewPasswordVC: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    @IBAction func updateButtonDidTap() {
        guard let password = passwordTextField.text else { return }
        guard let confirmPassword = confirmPasswordTextField.text else { return }
        
        if !password.isAlphanumeric {
            presentPasswordInvalidAlert()
            return
        }
        
        if !password.isEqual(confirmPassword) {
            presentPasswordsDontMatchAlert()
            return
        }
        
        
    }
    
    func setupTextFields() {
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
    }
    
    
    func presentPasswordInvalidAlert() {
        let alert = UIAlertController(title: "Password Invalid", message: "Please use both letters and numbers for your password.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentPasswordsDontMatchAlert() {
        let alert = UIAlertController(title: "Password Invalid", message: "Please use both letters and numbers for your password.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}


extension String {
    func isEqual(_ str: String) -> Bool {
        let isEqual = (self ==  str)
        return isEqual
    }
}
