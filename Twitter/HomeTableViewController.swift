//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Arman Kabir on 11/8/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    @objc func loadTweets(){
        //url to call the api and get JSON response of home timeline content
        numberOfTweets = 20
        let homeTimelineURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": numberOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: homeTimelineURL, parameters: params, success: {  (tweets: [NSDictionary]) in
            self.tweetArray.removeAll() //empty array each time receiving new tweets
            //append tweets to array from json
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
            
        }, failure: { (Error) in
            print("Tweet retreival failed!!!!!")
        })
        
    }
    
    func loadMoreTweets(){
        let homeTimelineURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets = numberOfTweets+20
        let params = ["count": numberOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: homeTimelineURL, parameters: params, success: {  (tweets: [NSDictionary]) in
            self.tweetArray.removeAll() //empty array each time receiving new tweets
            //append tweets to array from json
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("Tweet retreival failed!!!!!")
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row+1 == tweetArray.count{
            loadMoreTweets() //function enables infinite scroll
        }
    }
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil) //dismiss screen after logging out
        UserDefaults.standard.set(false, forKey: "userLoggedIn") //ensures logout to be remembered
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        //set username and tweet content
        cell.usernameLabel.text = user["name"] as? String
        cell.tweetLabel.text = tweetArray[indexPath.row]["text"] as? String
        
        //set profile picture of tweet
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        if let imageData = data {
            cell.profilePicView.image = UIImage(data: imageData)
        }
        
        
        return cell
    }
    
    
    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

  
}
