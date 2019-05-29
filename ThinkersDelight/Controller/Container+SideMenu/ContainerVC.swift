//
//  ContainerVC.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/20/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {
    
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    var sideMenuOpen = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleSideMenu),
                                               name: NSNotification.Name("ToggleSideMenu"),
                                               object: nil)
    }
    
    @objc func toggleSideMenu() {
        let inSession = UserDefaults.standard.bool(forKey: "InSession")
        
        if sideMenuOpen {
            sideMenuOpen = false
            self.sideMenuConstraint.constant = -240
            
            if inSession {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "StartTimer"), object: nil)
            }
        } else {
            sideMenuOpen = true
            self.sideMenuConstraint.constant = 0
            if inSession {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "StopTimer"), object: nil)
            }
        }
        UIView.animate(withDuration: 0.3, animations: {
             self.view.layoutIfNeeded()
        })
    }
}
