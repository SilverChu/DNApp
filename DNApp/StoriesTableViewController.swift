//
//  StoriesTableViewController.swift
//  DNApp
//
//  Created by Silver Chu on 2017/8/7.
//  Copyright © 2017年 Meng To. All rights reserved.
//

import UIKit

class StoriesTableViewController: UITableViewController, StoryTableViewCellDelegate, MenuViewControllerDelegate, LoginViewControllerDelegate {
    
    let transitionManager = TransitionManager()
    var stories: JSON! = []
    var isFirstTime = true
    var section = ""

    @IBOutlet weak var loginButton: UIBarButtonItem!
    
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
        
        loadStories("", page: 1)
        refreshControl?.addTarget(self, action: #selector(self.refreshStories), for: UIControlEvents.valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if isFirstTime {
            view.showLoading()
            isFirstTime = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell") as! StoryTableViewCell
        let story = stories[(indexPath as NSIndexPath).row]
        cell.configureWithStory(story)
        
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "WebSegue", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - StoryTableViewCellDelegate
    func storyTableViewCellDidTouchUpvote(cell: StoryTableViewCell, sender: Any) {
        if let token = LocalStore.getToken() {
            let indexPath = tableView.indexPath(for: cell)!
            let story = stories[indexPath.row]
            let storyId = story["id"].string!
            DNService.upvoteStoryWithId(storyId, token: token, completion: { (successful) -> () in
                print(successful)
            })
            LocalStore.saveUpvotedStory(storyId)
            cell.configureWithStory(story)
        } else {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }
    
    func storyTableViewCellDidTouchComment(cell: StoryTableViewCell, sender: Any) {
        performSegue(withIdentifier: "CommentsSegue", sender: cell)
    }
    
    // MARK: - MenuViewControllerDelegate
    func menuViewControllerDidTouchTop(_ controller: MenuViewController) {
        view.showLoading()
        loadStories("", page: 1)
        navigationItem.title = "Top Stories"
        section = ""
    }
    
    func menuViewControllerDidTouchRecent(_ controller: MenuViewController) {
        view.showLoading()
        loadStories("recent", page: 1)
        navigationItem.title = "Recent Stories"
        section = "recent"
    }
    
    func menuViewControllerDidTouchLogout(_ controller: MenuViewController) {
        loadStories(section, page: 1)
        view.showLoading()
    }
    
    // MARK: - LoginViewControllerDelegate
    func loginViewControllerDidLogin(_ controller: LoginViewController) {
        loadStories(section, page: 1)
        view.showLoading()
    }
    
    // MARK: - Misc
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CommentsSegue" {
            let toView = segue.destination as! CommentsTableViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            
            toView.story = stories[indexPath.row] as JSON
        }
        if segue.identifier == "WebSegue" {
            let toView = segue.destination as! WebViewController
            let indexPath = sender as! IndexPath
            let url = stories[indexPath.row]["url"].string!
            
            toView.url = url
            UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.fade)
            toView.transitioningDelegate = transitionManager
        }
        if segue.identifier == "MenuSegue" {
            let toView = segue.destination as! MenuViewController
            toView.delegate = self
        }
        if segue.identifier == "LoginSegue" {
            let toView = segue.destination as! LoginViewController
            toView.delegate = self
        }
    }
    
    func loadStories(_ section: String, page: Int) {
        DNService.storiesForSection(section, page: page) { (JSON) -> () in
            self.stories = JSON["stories"]
            self.tableView.reloadData()
            self.view.hideLoading()
            self.refreshControl?.endRefreshing()
        }
        if LocalStore.getToken() == nil {
            loginButton.title = "Login"
            loginButton.isEnabled = true
        } else {
            loginButton.title = ""
            loginButton.isEnabled = false
        }
    }
    
    func refreshStories() {
        loadStories(section, page: 1)
    }

}
