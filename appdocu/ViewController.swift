//
//  ViewController.swift
//  appdocu
//
//  Created by thuylinh on 7/8/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var buttlogup: UIButton!
    @IBOutlet weak var buttonsigin: UIButton!
    @IBOutlet weak var image : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.buttonchangehome(button: buttlogup)
        Utilities.buttonchangehome(button: buttonsigin)
        image.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        var user = Auth.auth().currentUser
        if (user != nil) {
            print("hhiajkds")
        } else {
            print("loi roi")
        }
    }
    
    @IBAction func signup(_ sender: Any) {
        let signupviewcontroller = SignupViewController()
        navigationController?.pushViewController(signupviewcontroller, animated: true)
    }
    
    @IBAction func signin(_ sender: Any) {
        let loginViewcontroller = LoginViewController()
        navigationController?.pushViewController(loginViewcontroller, animated: true)
    }
}

