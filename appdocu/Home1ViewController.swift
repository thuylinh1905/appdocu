//
//  Home1ViewController.swift
//  appdocu
//
//  Created by thuylinh on 7/23/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class Home1ViewController: UIViewController {
    
    @IBOutlet weak var buttlogup: UIButton!
    @IBOutlet weak var buttonsigin: UIButton!
    @IBOutlet weak var image : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.buttonchangehome(button: buttlogup)
        Utilities.buttonchangehome(button: buttonsigin)
        
    }
    
    @IBAction func signup(_ sender: Any) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.gotoSignup()
    }
    
    @IBAction func signin(_ sender: Any) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.gotoSignin()
    }
}
