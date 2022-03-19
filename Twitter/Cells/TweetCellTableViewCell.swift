//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Daniel Jiang on 3/11/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var favorited: Bool = false
    var tweetId: Int = -1
    var retweeted: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tweetContent.sizeToFit()
    }
    
    func setFavorite(_ isFavorited: Bool) {
        favorited = isFavorited
        if (favorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"),
                               for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named: "favor-icon"),
                               for: UIControl.State.normal)
        }
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(
                tweetId: tweetId,
                success: {
                    self.setFavorite(true)
                },
                failure: { (error) in
                    print("Favorite did not succeed: \(error)")
                }
            )
        }
        else {
            TwitterAPICaller.client?.unfavoriteTweet(
                tweetId: tweetId,
                success: {
                    self.setFavorite(false)
                },
                failure: { (error) in
                    print("Unfavorite did not succeed: \(error)")
                }
            )
        }
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        retweeted = isRetweeted
        if (retweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"),
                                   for: UIControl.State.normal)
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"),
                                   for: UIControl.State.normal)
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        let toBeRetweeted = !retweeted
        if (toBeRetweeted) {
            TwitterAPICaller.client?.retweet(
                tweetId: tweetId,
                success: {
                    self.setRetweeted(true)
                },
                failure: { (error) in
                    print("Retweet did not succeed: \(error)")
                }
            )
        }
        else {
            TwitterAPICaller.client?.unretweet(
                tweetId: tweetId,
                success: {
                    self.setRetweeted(false)
                },
                failure: { (error) in
                    print("Unretweet did not succeed: \(error)")
                }
            )
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
