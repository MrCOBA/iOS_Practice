//
//  ViewController.swift
//  ShowMe App
//
//  Created by Kukina Anastasia on 22.11.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "messageSegue" {
            
            guard let destination = segue.destination as? MessageViewController else { return }
            destination.text = messageField.text
        }
    }
}

