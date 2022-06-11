//
//  MessageViewController.swift
//  ShowMe App
//
//  Created by Kukina Anastasia on 22.11.2020.
//

import UIKit

class MessageViewController: UIViewController {
    
    var text: String? = ""
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = text
    }
}
