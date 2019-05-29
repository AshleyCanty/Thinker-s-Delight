//
//  SignupViewController+UIImagePickerDelegates.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/27/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

// MARK: - UIImagePickerDelegate

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] {
            if let image = pickedImage as? UIImage {
                profileImage.image = image
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func openImagePicker() {
        self.present(imagePicker, animated: true, completion: nil)    }
}
