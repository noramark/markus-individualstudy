//
//  SignInViewController.swift
//  IndividualStudyMarkus
//
//  Created by Eleanor Markus-19 on 1/16/19.
//  Copyright © 2019 Eleanor Markus-19. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class SignInViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //add any additional set up after loading the view here(?)
    }
    
    @IBAction func signInWithEmail(_sender: Any) {
        let authUI = FUIAuth.defaultAuthUI() //slightly shifted from the textbook wording
        if let authViewController = authUI?.authViewController() {
            present(authViewController, animated: true, completion:nil)
        }
    }
}
