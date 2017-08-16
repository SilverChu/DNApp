//
//  CommentsTableViewCell.swift
//  DNApp
//
//  Created by Silver Chu on 2017/8/10.
//  Copyright © 2017年 Meng To. All rights reserved.
//

import UIKit

protocol CommentsTableViewCellDelegate: class {
    func commentsTableViewCellDidTouchUpvote(_ cell: CommentsTableViewCell)
    func commentsTableViewCellDidTouchComment(_ cell: CommentsTableViewCell)
}

class CommentsTableViewCell: UITableViewCell {
    
    weak var delegate: CommentsTableViewCellDelegate?

    @IBOutlet weak var avatarImageView: AsyncImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var upvoteButton: SpringButton!
    @IBOutlet weak var replyButton: SpringButton!
    @IBOutlet weak var commentTextView: AutoTextView!
    
    @IBAction func upvoteButtonDidTouch(_ sender: Any) {
        delegate?.commentsTableViewCellDidTouchUpvote(self)
    }
    
    @IBAction func ReplyButtonDidTouch(_ sender: Any) {
        delegate?.commentsTableViewCellDidTouchComment(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithComment(_ comment: JSON) {
        let userDisplayName = comment["user_display_name"].string ?? ""
        let userJob = comment["user_job"].string ?? ""
        let createdAt = comment["created_at"].string!
        let voteCount = comment["vote_count"].int!
        let body = comment["body"].string!
        
        avatarImageView.image = UIImage(named: "content-avatar-default")
        authorLabel.text = userDisplayName + ", " + userJob
        timeLabel.text = timeAgoSinceDate(date: dateFromString(date: createdAt, format: "yyyy-MM-dd'T'HH:mm:ssZ"), numericDates: true)
        upvoteButton.setTitle(String(voteCount), for: UIControlState.normal)
        commentTextView.text = body
    }

}
