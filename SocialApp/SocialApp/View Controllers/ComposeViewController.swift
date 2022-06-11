//
//  ComposeViewController.swift
//  SocialApp
//
//  Created by Kukina Anastasia on 27.11.2020.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var tweetContent: UITextView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var postActivity: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func dismissView(_ sender: Any) {
    }
    
    @IBAction func postToTwitter(_ sender: Any) {
    }
    
}
