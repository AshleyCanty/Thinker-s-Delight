//
//  SignUpViewController+TextFieldDelegates.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/23/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit


// MARK: - UITextField Delegates

extension SignUpViewController: UITextFieldDelegate {
    
    func setupTextFieldDelegates() {
        emailTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
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
