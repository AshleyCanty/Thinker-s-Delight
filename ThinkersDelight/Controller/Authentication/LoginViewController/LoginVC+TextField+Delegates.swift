//
//  LoginVC+TextField+Delegates.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/27/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

// MARK: - UITextField Delegates

extension LoginViewController: UITextFieldDelegate {
    
    
    func setupTextFieldDelegates() {
        emailTextField.delegate = self
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
        let tf = [emailTextField, passwordTextField]
        tf.forEach { (t) in
            t?.layer.borderWidth = 0
            t?.rightView = .none
        }
    }
    
    func removeSelectedTextField(textField: UITextField) {
        if errorTextFields.contains(textField) {
            let emptyView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 40, height: 30))
            textField.layer.borderWidth = 0
            textField.rightView = emptyView
            let index = errorTextFields.firstIndex(of: textField)!
            errorTextFields.remove(at: index)
        }
    }
}
