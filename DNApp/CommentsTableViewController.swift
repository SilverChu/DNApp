//
//  CommentsTableViewController.swift
//  DNApp
//
//  Created by Silver Chu on 2017/8/10.
//  Copyright © 2017年 Meng To. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController {
    
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
        }
        
        if let commentCell = cell as? CommentsTableViewCell {
            let comment = comments[indexPath.row - 1]
            commentCell.configureWithComment(comment: comment)
        }
        
        return cell
    }
 
}
