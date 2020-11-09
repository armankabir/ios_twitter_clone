//
//  TweetCell.swift
//  Twitter
//
//  Created by Arman Kabir on 11/8/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilePicView: UIImageView! //profile pic for tweeter of tweet
    @IBOutlet weak var usernameLabel: UILabel!      //username for the tweeter
    @IBOutlet weak var tweetLabel: UILabel!         //content of the tweet itself
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
