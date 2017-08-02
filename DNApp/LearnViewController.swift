//
//  LearnViewController.swift
//  DNApp
//
//  Created by Meng To on 2015-01-31.
//  Copyright (c) 2015 Meng To. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController {

    @IBOutlet weak var dialogView: DesignableView!
    @IBOutlet weak var bookImageView: SpringImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        dialogView.animate()
    }
    
    @IBAction func learnButtonDidTouch(_ sender: AnyObject) {
        bookImageView.animation = "pop"
        bookImageView.animate()
    }

    @IBAction func closeButtonDidTouch(_ sender: AnyObject) {
        dialogView.animation = "fall"
        dialogView.animateNext {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
