//
//  HomescreenVC+APIHandlers.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/24/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import Foundation
import Firebase


// MARK: - UIImagePickerController

extension HomescreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] {
            if let image = pickedImage as? UIImage {
                profileImageView.image = image
                updateProfileWithNewImage()
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func loadImagePicker() {
        self.present(picker, animated: true, completion: nil)
    }
}
