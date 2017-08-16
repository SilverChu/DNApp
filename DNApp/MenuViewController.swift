//
//  MenuViewController.swift
//  DNApp
//
//  Created by Silver Chu on 2017/8/7.
//  Copyright © 2017年 Meng To. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate: class {
    func menuViewControllerDidTouchTop(_ controller: MenuViewController)
    func menuViewControllerDidTouchRecent(_ controller: MenuViewController)
    func menuViewControllerDidTouchLogout(_ controller: MenuViewController)
}

class MenuViewController: UIViewController {
    
    weak var delegate: MenuViewControllerDelegate?

    @IBOutlet weak var dialogView: DesignableView!
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBAction func closeButtonDidTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        dialogView.animation = "fall"
        dialogView.animate()
    }
    
    @IBAction func topButtonDidTouch(_ sender: Any) {
        delegate?.menuViewControllerDidTouchTop(self)
        closeButtonDidTouch(sender)
    }
    
    @IBAction func recentButtonDidTouch(_ sender: Any) {
        delegate?.menuViewControllerDidTouchRecent(self)
        closeButtonDidTouch(sender)
    }
    
    @IBAction func loginButtonDidTouch(_ sender: Any) {
        if LocalStore.getToken() == nil {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        } else {
            LocalStore.deleteToken()
            closeButtonDidTouch(sender)
            delegate?.menuViewControllerDidTouchLogout(self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if LocalStore.getToken() == nil {
            loginLabel.text = "Login"
        } else {
            loginLabel.text = "Logout"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
