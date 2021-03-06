//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Paulo Sousa on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    @IBOutlet weak var favButtton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTweets()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadTweets()
    }
    
    
    
    
    
    func loadTweets() {
        let requestUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": 20]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: requestUrl, parameters: params, success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("Error loading tweets!")
        })
    }
    
    

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContentLabel.text = tweetArray[indexPath.row]["text"] as? String
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        cell.setFavorite( tweetArray[indexPath.row]["favorited"] as! Bool )
        cell.setRetweeted( tweetArray[indexPath.row]["retweeted"] as! Bool )
        
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        
        return cell;
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count
    }
    
    

}
