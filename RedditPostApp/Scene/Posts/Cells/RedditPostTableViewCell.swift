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

    private var id: String = ""

    private var action: ((String) -> Void)?

    private weak var fetchDataWorkItem: DispatchWorkItem?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        dismissButton.addTarget(self, action: #selector(buttonWasPressed), for: .touchUpInside)
    }

    func setupCell(viewModel: Posts.RedditPosts.ViewModel.DisplayedRedditPost, action: @escaping ((String) -> Void)) {
        authorLabel.text = viewModel.author
        createdLabel.text = viewModel.created
        titleLabel.text = viewModel.title
        commentsLabel.text = viewModel.commentCount
        self.id = viewModel.id
        self.action = action
        downloadImage(withURL: viewModel.thumbnailURL)
    }

    @objc
    private func buttonWasPressed() {
        action?(id)
    }


    private func downloadImage(withURL string: String?) {
        guard let urlString = string else {
            postImageView.image = #imageLiteral(resourceName: "placeholder")
            return
        }
        if let data = RedditAPI.shared.cache.object(forKey: urlString as NSString) {
            let image = UIImage(data: data as Data)
            postImageView.image = image
        } else {
            guard let url = URL(string: urlString) else {
                postImageView.image = #imageLiteral(resourceName: "placeholder")
                return
            }
            var workItem: DispatchWorkItem?
            workItem = DispatchWorkItem(block: {
                guard let dispatchWorkItem = workItem, !dispatchWorkItem.isCancelled else {
                    workItem = nil
                    return
                }

                guard let data = try? Data(contentsOf: url) else {
                    self.postImageView.image = #imageLiteral(resourceName: "placeholder")
                    return
                }
                RedditAPI.shared.cache.setObject(data as NSData, forKey: urlString as NSString)
                let image = UIImage(data: data)
                if let workItem = workItem, !workItem.isCancelled {
                    DispatchQueue.main.async {
                        // Configure Thumbnail Image View
                        self.postImageView.image = image
                    }
                }
            })

            if let workItem = workItem {
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.5, execute: workItem)

                fetchDataWorkItem = workItem
            }

            // Clean Up
            workItem?.notify(queue: .main) {
                workItem = nil
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        fetchDataWorkItem?.cancel()

        postImageView.image = #imageLiteral(resourceName: "placeholder")
    }
    
}
