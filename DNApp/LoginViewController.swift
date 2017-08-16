//
//  LoginViewController.swift
//  DNApp
//
//  Created by Meng To on 2015-01-29.
//  Copyright (c) 2015 Meng To. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    func loginViewControllerDidLogin(_ controller: LoginViewController)
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    weak var delegate: LoginViewControllerDelegate?
    
    @IBOutlet weak var dialogView: DesignableView!
    @IBOutlet weak var emailImageView: SpringImageView!
    @IBOutlet weak var passwordImageView: SpringImageView!
    @IBOutlet weak var emailTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    
    @IBAction func CloseButtonDidTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButtonDidTouch(_ sender: AnyObject) {
        DNService.loginWithEmail(email: emailTextField.text!, password: passwordTextField.text!) { (token) -> () in
            if let token = token {
                print(token)
                LocalStore.saveToken(token)
                self.dismiss(animated: true, completion: nil)
                self.delegate?.loginViewControllerDidLogin(self)
            } else {
                self.dialogView.animation = "shake"
                self.dialogView.animate()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do something
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true) // 取消软键盘
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailImageView.image = UIImage(named: "icon-mail-active")
            emailImageView.animate()
        } else {
            emailImageView.image = UIImage(named: "icon-mail")
        }
        
        if textField == passwordTextField {
            passwordImageView.image = UIImage(named: "icon-password-active")
            passwordImageView.animate()
        } else {
            passwordImageView.image = UIImage(named: "icon-password")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        emailImageView.image = UIImage(named: "icon-mail")
        passwordImageView.image = UIImage(named: "icon-password")
    }
    
}
