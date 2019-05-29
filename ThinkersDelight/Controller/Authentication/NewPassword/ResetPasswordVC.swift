//
//  ResetPasswordVC.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/28/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetStatusLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    var spinnerContainer: UIView!
    var smallContainer: UIView!
    var updateLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resetButtonDidTap() {
        guard let email = emailTextField.text else { return }
        
        if email == "" || !validateEmail(enteredEmail: email) {
            presentEmailInvalidAlert()
            return
        }
        setupSpinner()
        checkIfEmailInUse(email) { (success) in
            if success {
                Auth.auth().sendPasswordReset(withEmail: email) { (err) in
                    if err == nil {
                        self.removeSpinner()
                        self.statusView.backgroundColor = Colors.yellow
                        self.resetStatusLabel.text = "An email has been sent!"
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.5, execute: {
                            self.navigationController?.popViewController(animated: true)
                        })
                    } else {
                        self.removeSpinner()
                    }
                }
            }
        }
        
    }
    
    func checkIfEmailInUse(_ email: String, completion: @escaping ((_ success: Bool) -> ())) {
        Auth.auth().fetchSignInMethods(forEmail: email) { (result, err) in
            if err == nil {
                if let res = result {
                    if res.count > 0 {
                        res.forEach({ (r) in
                            print(res)
                            if r.contains("password") {
                                completion(true)
                            }
                        })
                    } else {
                        self.presentEmailDoesNotExistAlert()
                        completion(false)
                    }
                } else {
                    self.presentEmailDoesNotExistAlert()
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
    
    func presentProcessingErrorAlert() {
        let alert = UIAlertController(title: "Error Verifying Email", message: "There was an error processing you information. Please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentEmailInvalidAlert() {
        let alert = UIAlertController(title: "Email Invalid", message: "Please make sure the email entered is in a valid format.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentEmailDoesNotExistAlert() {
        let alert = UIAlertController(title: "Email Does Not Exist", message: "Our records show that the email entered does not exist in our database.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupSpinner() {
        spinnerContainer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        spinnerContainer?.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        smallContainer = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        smallContainer.clipsToBounds = true
        smallContainer.layer.cornerRadius = 8
        smallContainer.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        updateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        updateLabel.text = "Sending data..."
        updateLabel.textColor = UIColor.white
        updateLabel.textAlignment = .center
        updateLabel.numberOfLines = 2
        updateLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        
        smallContainer?.addSubview(updateLabel)
        smallContainer?.addSubview(spinner)
        
        spinner.center = smallContainer!.center
        spinner.center.y -= 20
        updateLabel.center.x = spinner.center.x
        updateLabel.center.y = spinner.center.y+35
        
        spinnerContainer.addSubview(smallContainer)
        smallContainer.center = spinnerContainer.center
        
        DispatchQueue.main.async {
            self.spinner.startAnimating()
            self.view.addSubview(self.spinnerContainer!)
        }
    }
    
    func removeSpinner() {
        if spinnerContainer != nil && (spinnerContainer?.isDescendant(of: view))! {
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.spinnerContainer?.removeFromSuperview()
            }
        }
    }
}
