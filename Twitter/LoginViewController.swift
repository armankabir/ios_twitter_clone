//
//  LoginViewController.swift
//  Twitter
//
//  Created by Arman Kabir on 11/6/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //if user was previously logged in, segue back to app home screen
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            self.performSegue(withIdentifier: "loginToHomeSegue", sender: self)
        }
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let loginURL = "https://api.twitter.com/oauth/request_token"
        //calling api to login
        TwitterAPICaller.client?.login(url: loginURL, success: {
            //keep user logged in by setting login key to true
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            //on successful login, segue to the home navigation contoller with loginToHomeSegue
            self.performSegue(withIdentifier: "loginToHomeSegue", sender: self)
        }, failure: { (Error) in
            //print error message to console if login fails 
            print("Login Failed!")
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
