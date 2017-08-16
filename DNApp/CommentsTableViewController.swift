//
//  CommentsTableViewController.swift
//  DNApp
//
//  Created by Silver Chu on 2017/8/10.
//  Copyright © 2017年 Meng To. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController, CommentsTableViewCellDelegate, StoryTableViewCellDelegate {
    
    var story: JSON!
    var comments: JSON!

    override func viewDidLoad() {
        super.viewDidLoad()

        comments = story["comments"]
        
        tableView.estimatedRowHeight = 140 // 为什么必须写这行代码cell才正常运行？
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return comments.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = indexPath.row == 0 ? "StoryCell":"CommentCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        
        if let storyCell = cell as? StoryTableViewCell {
            storyCell.configureWithStory(story)
            storyCell.delegate = self
        }
        
        if let commentCell = cell as? CommentsTableViewCell {
            let comment = comments[indexPath.row - 1]
            commentCell.configureWithComment(comment)
            commentCell.delegate = self
        }
        
        return cell
    }
    
    // MARK: - StoryTableViewCellDelegate
    func storyTableViewCellDidTouchUpvote(cell: StoryTableViewCell, sender: Any) {
        if let token = LocalStore.getToken() {
            // let indexPath = tableView.indexPath(for: cell)!
            let storyId = story["id"].string!
            DNService.upvoteStoryWithId(storyId, token: token, completion: { (successful) in
                
            })
            LocalStore.saveUpvotedStory(storyId)
            cell.configureWithStory(story)
        } else {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }
    
    func storyTableViewCellDidTouchComment(cell: StoryTableViewCell, sender: Any) {
        
    }
    
    // MARK: - CommentsTableViewCellDelegate
    func commentsTableViewCellDidTouchUpvote(_ cell: CommentsTableViewCell) {
        if let token = LocalStore.getToken() {
            let indexPath = tableView.indexPath(for: cell)!
            let comment = comments[indexPath.row - 1]
            let commentId = comment["id"].string!
            DNService.upvoteCommentWithId(commentId, token: token, completion: { (successful) in
                
            })
            LocalStore.saveUpvotedComment(commentId)
            cell.configureWithComment(comment)
        } else {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }
    
    func commentsTableViewCellDidTouchComment(_ cell: CommentsTableViewCell) {
        
    }
 
}
