//
//  secureViewController.swift
//  ExamApp
//
//  Created by OparinOleg on 02.06.2020.
//  Copyright © 2020 OparinOleg. All rights reserved.
//

import Foundation
import UIKit

class secureViewController:UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var tokenField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    let correctToken:String = "1234"
    let correctPassword:String = "1234"
    
    @IBOutlet weak var backButton: UIButton!
    let alert = UIAlertController(title: "Error", message: "Incorrect token or password!", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true);
        tokenField.delegate = self
        passwordField.delegate = self
        confirmButton.layer.cornerRadius = 15
        backButton.layer.cornerRadius = 15
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                    print("default")

              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")
              @unknown default:
                print("unknown default")
            }}))
    }
    
    
    @IBAction func confirmBtnPressed(_ sender: Any) {
        if tokenField.text! != correctToken || passwordField.text! != correctPassword{
            self.present(alert, animated: true, completion: nil);
        }
        else{
            performSegue(withIdentifier: "startEditing", sender: nil)
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "cancel", sender: nil)
    }
    
}
