//
//  StoryTableViewCell.swift
//  DNApp
//
//  Created by Silver Chu on 2017/8/7.
//  Copyright © 2017年 Meng To. All rights reserved.
//

import UIKit

protocol StoryTableViewCellDelegate: class {
    func storyTableViewCellDidTouchUpvote(cell: StoryTableViewCell, sender: Any)
    func storyTableViewCellDidTouchComment(cell: StoryTableViewCell, sender: Any)
}

class StoryTableViewCell: UITableViewCell {
    
    weak var delegate: StoryTableViewCellDelegate?

    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var upvoteButton: SpringButton!
    @IBOutlet weak var commentButton: SpringButton!
    @IBOutlet weak var commentTextView: AutoTextView!
    
    @IBAction func upvoteButtonDidTouch(_ sender: Any) {
        upvoteButton.animation = "pop"
        upvoteButton.force = 3
        upvoteButton.animate()
        delegate?.storyTableViewCellDidTouchUpvote(cell: self, sender: sender)
    }
    
    @IBAction func commentButtonDidTouch(_ sender: Any) {
        commentButton.animation = "pop"
        commentButton.force = 3
        commentButton.animate()
        delegate?.storyTableViewCellDidTouchComment(cell: self, sender: sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithStory(_ story: JSON) {
        let title = story["title"].string!
        let badge = story["badge"].string ?? ""
        // let userPortraitUrl = story["userPortraitUrl"].string ?? ""
        // let userDisplayName = story["user_display_name"].string!
        // let userJob = story["user_job"].string!
        let createdAt = story["created_at"].string!
        let voteCount = story["vote_count"].int!
        let commentCount = story["comment_count"].int!
        let comment = story["comment"].string
        // let commentHTML = story["comment_html"].string ?? ""
        
        titleLabel.text = title
        badgeImageView.image = UIImage(named: "badge-" + badge)
        avatarImageView.image = UIImage(named: "content-avatar-default")
        // authorLabel.text = userDisplayName + ", " + userJob
        timeLabel.text = timeAgoSinceDate(date: dateFromString(date: createdAt, format: "yyyy-MM-dd'T'HH:mm:ssZ"), numericDates: true)
        upvoteButton.setTitle(String(voteCount), for: UIControlState.normal)
        commentButton.setTitle(String(commentCount), for: UIControlState.normal)
        if let commentTextView = commentTextView {
            commentTextView.text = comment
            // commentTextView.attributedText = htmlToAttributedString(text: commentHTML + "<style>*{font-family:\"Avenir Next\";font-size:16px;line-height:20px}img{max-width:300px}</style>")
        }
        
        let storyId = story["id"].string!
        if LocalStore.isStoryUpvoted(storyId) {
            upvoteButton.setImage(UIImage(named: "icon-upvote-active"), for: .normal)
            upvoteButton.setTitle(String(voteCount + 1), for: .normal)
        } else {
            upvoteButton.setImage(UIImage(named: "icon-upvote"), for: .normal)
            upvoteButton.setTitle(String(voteCount), for: .normal)
        }
    }

}
