//
//  StoriesTableViewController.swift
//  DNApp
//
//  Created by Silver Chu on 2017/8/7.
//  Copyright © 2017年 Meng To. All rights reserved.
//

import UIKit

class StoriesTableViewController: UITableViewController {

    @IBAction func menuButtonDidTouch(_ sender: Any) {
        performSegue(withIdentifier: "MenuSegue", sender: self)
    }
    
    @IBAction func loginButtonDidTouch(_ sender: Any) {
        performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell") as! StoryTableViewCell
        
        cell.titleLabel.text = "Learn iOS Design and Xcode."
        cell.badgeImageView.image = UIImage(named: "badge-apple")
        cell.avatarImageView.image = UIImage(named: "content-avatar-default")
        cell.authorLabel.text = "Meng To, designer and coder."
        cell.timeLabel.text = "5m"
        cell.upvoteButton.setTitle("59", for: UIControlState.normal)
        cell.commentButton.setTitle("32", for: UIControlState.normal)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "WebSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
