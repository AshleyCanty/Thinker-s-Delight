//
//  SignUpViewController+UI+Handlers.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/28/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

// MARK: - UI Helpers (Alerts, Delegates)

extension SignUpViewController {
    
    func presentPasswordInvalidAlert() {
        let alert = UIAlertController(title: "Password Invalid", message: "Please use both letters and numbers for your password.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentEmailInUseAlert() {
        let alert = UIAlertController(title: "Email in Use", message: "Our records show that the email entered is already in use.", preferredStyle: .alert)
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
    
    func presentAuthenticationAlert() {
        let alert = UIAlertController(title: "Authentication Error", message: "Please make sure that your:\n -Email is valid\n -Password is alteast 6 characters", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentProcessingErrorAlert() {
        let alert = UIAlertController(title: "Error Verifying Email", message: "There was an error processing you information. Please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func addWarningLabel() {
        warning = UILabel(frame: CGRect(x: 0, y: 0, width: passwordTextField.bounds.width-20, height: 50))
        warning.text = "Please make valid entries in the highlighted fields."
        warning.textColor = UIColor.red
        warning.textAlignment = .center
        warning.numberOfLines = 2
        warning.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        textFieldStackView.addArrangedSubview(warning)
        warningFlag = true
    }
    
    func removeWarningLabel() {
        if warning != nil && warning.isDescendant(of: textFieldStackView) {
            warning.removeFromSuperview()
            self.warningFlag = false
        }
    }
    
    func setupProfileImageAndImagePicker(){
        let imageTap =  UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profileImage.isUserInteractionEnabled = true
        profileImage.layer.cornerRadius = profileImage.bounds.width/2
        profileImage.clipsToBounds = true
        addImageButton.addGestureRecognizer(imageTap)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
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
