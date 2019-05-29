//
//  LoginViewController.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/18/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//


import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var textFieldStackView: UIStackView!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    var spinnerContainer: UIView?
    var errorTextFields: [UITextField] = []
    var warningFlag = false
    var warning: UILabel!
    var user: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFields()
    }
    
    @IBAction func forgotPasswordButtonDidTap() {
        performSegue(withIdentifier: "resetPassword", sender: nil)
    }

    @IBAction func loginButtonDidTap() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        errorTextFields = []
        
        if email == "" {
            errorTextFields.append(emailTextField)
        }

        if password == "" {
            errorTextFields.append(passwordTextField)
        }
        
        if errorTextFields.count > 0 {
            setAlertIcons(textFields: errorTextFields)
            return
        } else {
            setupSpinner()
            signUserIntoFirebase(email, password)
        }
        
    }

    func signUserIntoFirebase(_ email: String,_ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("Error: \(err.localizedDescription)")
                DispatchQueue.main.async {
                    self.removeSpinner()
                }
                self.checkErrorType(err.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                self.removeSpinner()
            }
            self.removeAlertsFromTextFields()
            self.removeWarningLabel()
            self.pushToHomescreenVC()
            print("User successfully signed in!")
            
        }
    }
    
    func checkErrorType(_ err: String) {
        if err.contains("password is invalid") {
            presentAuthErrorAlert(err)
        } else if err.contains("no user record corresponding to this identifier") {
            presentAuthErrorAlert("There is no user record corresponding to this email. The user may have been deleted.")
        } else {
            self.presentAuthenticationAlert()
        }
        
        
    }
    
    func presentAuthErrorAlert(_ err: String){
        let alert = UIAlertController(title: "Authentication Error", message: "\(err)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func pushToHomescreenVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomescreenViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentAuthenticationAlert() {
        let alert = UIAlertController(title: "Authentication Error", message: "Please make sure that your:\n -Email is valid\n -Password is alteast 6 characters", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setAlertIcons(textFields: [UITextField]) {
        textFields.forEach { (tf) in
            tf.setIcon(UIImage(named: "alert-symbol")!, .right)
            tf.borderStyle = .roundedRect
            tf.layer.borderColor = UIColor.red.cgColor
            tf.layer.borderWidth = 1
        }
        if !warningFlag {
            addWarningLabel()
        }
    }
    
    func addWarningLabel() {
        warning = UILabel(frame: CGRect(x: 0, y: 0, width: passwordTextField.bounds.width-20, height: 50))
        warning.text = "Please enter both a valid email and password"
        warning.textColor = UIColor.white
        warning.textAlignment = .center
        warning.numberOfLines = 2
        warning.font = UIFont.boldSystemFont(ofSize: 14.0)

        textFieldStackView.addArrangedSubview(warning)
        warningFlag = true
    }
    
    func removeWarningLabel() {
        if warning != nil && warning.isDescendant(of: textFieldStackView) {
            warning.removeFromSuperview()
            warningFlag = false
        }
    }
    
    func setTextFields() {
        setIconsInTextFeilds()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
    }

    func setIconsInTextFeilds() {
        errorTextFields = [emailTextField,passwordTextField]
        errorTextFields.forEach { (tf) in
            let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 40, height: 30))
            tf.rightView = iconContainerView
            tf.rightViewMode = .always
        }
        emailTextField.setIcon(UIImage(named: "user")!, .left)
        passwordTextField.setIcon(UIImage(named: "lock")!, .left)
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


