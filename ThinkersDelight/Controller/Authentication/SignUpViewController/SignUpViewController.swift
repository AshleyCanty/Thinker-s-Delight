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
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var textFieldStackView: UIStackView!
    
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    var spinnerContainer: UIView!
    var smallContainer: UIView!
    var updateLabel: UILabel!
    var errorTextFields: [UITextField] = []
    var warningFlag = false
    var warning: UILabel!
    var user: User!
    
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        user = User()
        setupTextFieldDelegates()
        setupProfileImageAndImagePicker()
    }
    
    @IBAction func signupButtonDidTap() {
        
        guard let image = self.profileImage.image else { return }
        guard let email = emailTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        errorTextFields = []
        
        if email == "" {
            errorTextFields.append(emailTextField)
        }
        
        if !validateEmail(enteredEmail: email) {
            presentEmailInvalidAlert()
            errorTextFields.append(emailTextField)
        }
        
        if username == ""  {
            errorTextFields.append(usernameTextField)
        }
        
        if password == "" {
            errorTextFields.append(passwordTextField)
        }
        
        if !password.isAlphanumeric {
            presentPasswordInvalidAlert()
        }
        
        if errorTextFields.count > 0 {
            setAlertIcons(textFields: errorTextFields)
            return
        } else {
            setupSpinner()
            checkIfEmailInUse(email) { (success) in
                if success {
                    self.authenticateUserInFirebaseDB(email, username, password, image)
                } else {
                    self.removeSpinner()
                    self.presentEmailInUseAlert()
                }
            }
        }
    }
    
    
    func checkIfEmailInUse(_ email: String, completion: @escaping ((_ success: Bool) -> ())) {
        Auth.auth().fetchSignInMethods(forEmail: email) { (result, err) in
            self.updateLabel.text = "Checking credentials"
            if err == nil {
                if let res = result {
                    if res.count > 0 {
                        res.forEach({ (r) in
                            print(res)
                            if r.contains("password") {
                                completion(false)
                            }
                        })
                    } else {
                        completion(true)
                    }
                } else {
                    completion(true)
                }
            } else {
                self.presentProcessingErrorAlert()
                print("Error: \(err?.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    // MARK: - Navigation
    
    func pushToHomescreenVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomescreenViewController

        self.navigationController?.pushViewController(vc, animated: true)
    }
}

