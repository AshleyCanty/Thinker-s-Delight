//
//  HomescreenVC+MainMenuHandlers.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/25/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit
import Firebase


// MARK: - Main Menu Handlers

extension HomescreenViewController {
    
    @objc func showMainMenu() {
        let inSession = UserDefaults.standard.bool(forKey: "InSession")
        
        if inSession {
            gameInSessionAlert(vcOptions: 1)
            return
        }
        self.goToMainMenu()
    }
    
    func goToMainMenu() {
        for vc in (self.navigationController?.viewControllers ?? []) {
            if vc is HomescreenViewController {
                _ = self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
    @objc func logout() {
        let inSession = UserDefaults.standard.bool(forKey: "InSession")
        if inSession {
            gameInSessionAlert(vcOptions: 0)
            return
        }
        signOutOfFirebase()
        navigationController?.popToRootViewController(animated: true)
    }
    
    func signOutOfFirebase() {
        if Auth.auth().currentUser != nil {
            try! Auth.auth().signOut()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "verifyLogout"), object: nil)
        }
    }
    
    func gameInSessionAlert(vcOptions: Int){
        let alert = UIAlertController(title: "Are You Sure?", message: "You are about to end a game that is in-session.", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Quit", style: .destructive, handler:{(_) in
            if vcOptions == 0 { // 0 = Logout
                self.navigationController?.popToRootViewController(animated: true)
            }
            if vcOptions == 1 { // 1 = Main menu
                self.goToMainMenu()
            }
        })
        let no = UIAlertAction(title: "Remain", style: .default, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        present(alert, animated: true, completion: nil)
    }
}
