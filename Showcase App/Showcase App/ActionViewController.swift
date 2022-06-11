//
//  ActionViewController.swift
//  Showcase App
//
//  Created by Kukina Anastasia on 23.11.2020.
//

import UIKit

class ActionViewController: UIViewController {
    
    @IBOutlet weak var actionController: UISegmentedControl!
    @IBOutlet weak var showmeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showmeButton.backgroundColor = UIColor(
            red: 9/255.0,
            green: 95/255.0,
            blue: 134/255.0,
            alpha: 1.0)
        showmeButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        showmeButton.layer.cornerRadius = 4.0
    }
    
    @IBAction func performAction(_ sender: Any) {
        
        if actionController.selectedSegmentIndex == 0 {
            
            let controller: UIAlertController = UIAlertController(
                title: "This is an alert",
                message: "You've created an alert view",
                preferredStyle: .alert)
            let okAction: UIAlertAction = UIAlertAction(
                title: "Okay",
                style: .default,
                handler: {
                    (alert: UIAlertAction!) in controller.dismiss(
                        animated: true,
                        completion: nil)
                    
                })
            controller.addAction(okAction)
            self.present(controller, animated: true, completion: nil)
        } else {
            
            let controller: UIAlertController = UIAlertController(
                title: "This is an action sheet",
                message: "You've created an action sheet",
                preferredStyle: .actionSheet)
            let okAction: UIAlertAction = UIAlertAction(
                title: "Okay",
                style: .default,
                handler: {
                    (alert: UIAlertAction!) in controller.dismiss(
                        animated: true,
                        completion: nil)
                    
                })
            controller.addAction(okAction)
            self.present(controller, animated: true, completion: nil)
        }
    }
    
}
