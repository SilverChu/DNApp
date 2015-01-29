//
//  LoginViewController.swift
//  DNApp
//
//  Created by Meng To on 2015-01-29.
//  Copyright (c) 2015 Meng To. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var dialogView: DesignableView!
    
    @IBAction func loginButtonDidTouch(sender: AnyObject) {
        dialogView.animation = "shake"
        dialogView.animate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do something
    }
    
}