//
//  HomescreenViewController.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/18/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

let imageCache = NSCache<AnyObject, AnyObject>()

class HomescreenViewController: UIViewController {
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var highScoresButton: UIButton!
    @IBOutlet weak var howToPlayButton: UIButton!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var user: User?
    var picker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = User()
        setupUser()
        setupProfileImageAndImagePicker()
        navigationItem.leftBarButtonItem = menuButton
        UserDefaults.standard.set(false, forKey: "InSession")
        NotificationCenter.default.addObserver(self, selector: #selector(showMainMenu), name: NSNotification.Name("showMainMenu"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: NSNotification.Name("Logout"), object: nil)
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UserDefaults.standard.set(false, forKey: "InSession")
    }
    
    @IBAction func onMoreTapped() {
        NotificationCenter.default.post(name: Notification.Name("ToggleSideMenu"), object: nil)
    }
    
    func setupUser() {
        setupUsername()
        getProfileImageUrl()
    }
    
    func setupProfileImageAndImagePicker(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(loadImagePicker))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
        profileImageView.contentMode = .scaleAspectFill
        if Auth.auth().currentUser?.uid != nil {
            profileImageView.isUserInteractionEnabled = true
        } else {
            profileImageView.isUserInteractionEnabled = false
        }
        
        picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
    }
    
    // MARK: - UINavigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryboardSegues.GameCategory.rawValue {
            if let user = user {
                UserDefaults.standard.set(user.username, forKey: "username")
                UserDefaults.standard.set(user.photoURL, forKey: "photoURL")
            }
        }
    }
}

