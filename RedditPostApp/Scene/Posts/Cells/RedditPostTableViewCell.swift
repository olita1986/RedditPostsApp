//
//  RedditPostTableViewCell.swift
//  RedditPostApp
//
//  Created by Nisum on 11/17/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import UIKit

class RedditPostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var commentsLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    func setupCell(viewModel: Posts.RedditPosts.ViewModel.DisplayedRedditPost) {
        authorLabel.text = viewModel.author
        createdLabel.text = viewModel.created
        titleLabel.text = viewModel.title
        commentsLabel.text = viewModel.commentCount
    }
    
}
