//
//  LoginViewController.swift
//  Twitter
//
//  Created by Paulo Sousa on 10/8/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 15;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    

    @IBAction func onLoginButton(_ sender: Any) {
        
        let requestUrl = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: requestUrl, success: {
            //On Successful Call -> Segue
            
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
            
        }, failure: { (Error) in
            print("Error loging in! :(")
        })
    }

}
