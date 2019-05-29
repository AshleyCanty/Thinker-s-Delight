//
//  SignUpViewController.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/18/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var textFieldStackView: UIStackView!
    
    
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    var spinnerContainer: UIView?
    var errorTextFields: [UITextField] = []
    var warningFlag = false
    var user: User!
    var warning: UILabel!
    
    
    override func viewDidLoad() {
        user = User()
        setupTextFieldDelegates()
    }
    
    @IBAction func signupButtonDidTap() {

        guard let email = emailTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        errorTextFields = []
        
        if email == "" {
            errorTextFields.append(emailTextField)
        }
        if username == ""  {
            errorTextFields.append(usernameTextField)
        }
        if password == "" {
            errorTextFields.append(passwordTextField)
        }
        
        if errorTextFields.count > 0 {
            setAlertIcons(textFields: errorTextFields)
            return
        } else {
            setupSpinner()
            authenticateUserInFirebaseDB(email, username, password)
        }
    }
    
    func setAlertIcons(textFields: [UITextField]) {
        textFields.forEach { (tf) in
            let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 40, height: 30))
            tf.leftView = iconContainerView
            tf.leftViewMode = .always
            tf.setIcon(UIImage(named: "alert-symbol")!, .right)
            tf.borderStyle = .roundedRect
            tf.layer.borderColor = UIColor.red.cgColor
            tf.layer.borderWidth = 1
        }
        if !warningFlag {
            addWarningLabel()
        }
    }
    
    func presentAuthenticationAlert() {
        let alert = UIAlertController(title: "Authentication Error", message: "There was an error during authentication. please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func addWarningLabel() {
        warning = UILabel(frame: CGRect(x: 0, y: 0, width: passwordTextField.bounds.width-20, height: 50))
        warning.text = "Please make valid entries in the highlighted fields."
        warning.textColor = UIColor.red
        warning.font = UIFont(name: "Helvetica-Neue", size: 12.0)
        warning.numberOfLines = 2
        warning.textAlignment = .center
        textFieldStackView.addArrangedSubview(warning)
        warningFlag = true
    }
    
    func removeWarningLabel() {
        warning.removeFromSuperview()
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
    
    // MARK: - Navigation
    
    func pushToHomescreenVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomescreenViewController
        vc.user = self.user
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITextField Handlers

extension SignUpViewController: UITextFieldDelegate {
    
    func setupTextFieldDelegates() {
        emailTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        removeSelectedTextField(textField: textField)
        if errorTextFields.count == 0 && warningFlag {
            removeWarningLabel()
            warningFlag = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        removeSelectedTextField(textField: textField)
        if errorTextFields.count == 0 && warningFlag {
            removeWarningLabel()
            warningFlag = false
        }
        return true
    }
    
    func removeAlertsFromTextFields() {
        usernameTextField.removeAlertBorderAndIcon()
        emailTextField.removeAlertBorderAndIcon()
        passwordTextField.removeAlertBorderAndIcon()
    }
    
    
    func removeSelectedTextField(textField: UITextField) {
        if errorTextFields.contains(textField) {
            textField.removeAlertBorderAndIcon()
            let index = errorTextFields.firstIndex(of: textField)!
            errorTextFields.remove(at: index)
        }
    }
}

extension UITextField {
    func removeAlertBorderAndIcon() {
        layer.borderWidth = 0
        rightView = .none
        leftView = .none
    }
}


// MARK: - Firebase Fetches

extension SignUpViewController {
    
    func authenticateUserInFirebaseDB(_ email: String,_ username: String,_ password: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, err) in
            if err == nil && user != nil {
                print("User created!")
                print(user?.additionalUserInfo)
                print(user?.user.email)
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges(completion: { (err) in
                    if err != nil {
                        print("Error: \(err?.localizedDescription)")
                        self.removeAlertsFromTextFields()
                        self.removeWarningLabel()
                        self.warningFlag = false
                        return
                    }
                })
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                    self.removeSpinner()
                    self.pushToHomescreenVC()
                }
            } else {
                print("Error: \(err!.localizedDescription)")
                self.removeSpinner()
                self.presentAuthenticationAlert()
            }
            self.removeAlertsFromTextFields()
            self.removeWarningLabel()
            self.warningFlag = false
        }
    }
}
