//
//  Extensions.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/18/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

enum TextFieldSide {
    case left
    case right
}

enum ImageNames: String {
    case AlertSymbol = "alert-symbol"
    case checkmark = "checkmark"
}

extension String {
    
    mutating func replaceCharacters() {
        self = self.replacingOccurrences(of: "&quot;", with: "\"")
        self = self.replacingOccurrences(of: "&#039;", with: "'")
        self = self.replacingOccurrences(of: "&acute;", with: "´")
        self = self.replacingOccurrences(of: "&eacute;", with: "´")
        self = self.replacingOccurrences(of: "&ldquo;", with: "\"")
        self = self.replacingOccurrences(of: "&rdquo;", with: "\"")
    }
    
    var isAlphabetic: Bool {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
    var isNumeric: Bool {
        return !isEmpty && range(of: "[^0-9]", options: .regularExpression) == nil
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString (_ urlString: String) {
        // 1. empty image if none available in cache or database
        self.image = nil
        
        // 2. load from chache if available
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject){
            self.image = cachedImage as? UIImage
            return
        }
        
        // 3. otherwise download from database
        if urlString == "" {
            self.image = UIImage(named: "user-image")
            return
        }
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
            }
            }.resume()
    }
}

extension UITextField {
    func setIcon(_ image: UIImage,_ side: TextFieldSide) {
        
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 40, height: 30))
        
        iconContainerView.addSubview(iconView)
        
        
        switch side {
            case .left:
                leftView = iconContainerView
                leftViewMode = .always
            self.tintColor = Colors.darkBlue
            case .right:
                rightView = iconContainerView
                rightViewMode = .always
                self.tintColor = .red
        }
    }
}



