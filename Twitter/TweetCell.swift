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
    @IBOutlet weak var nameLabel: UILabel!      //username for the tweeter
    @IBOutlet weak var tweetLabel: UILabel!         //content of the tweet itself
    @IBOutlet weak var twitterHandleLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    var liked: Bool = false
    var tweetId:Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onFavButton(_ sender: Any) {
        let toBeLiked = !liked
        if(toBeLiked){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavoriteImage(true)
            }, failure: { (error) in
                print("Failed to like. Error code: \(error)")
            })
        }
        else{
            TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetId, success: {
                self.setFavoriteImage(false)
            }, failure: { (error) in
                print("Failed to unlike. Error code: \(error)")
            })
        }
    }
    
    @IBAction func onRetweetButton(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Error retweeting! Error Code: \(error)")
        })
    }
    
    
    func setFavoriteImage(_ isLiked: Bool){
        liked = isLiked
        if(liked){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    func setRetweeted(_ isRetweeted: Bool){
        if(isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
}
