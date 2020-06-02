//
//  editViewController.swift
//  ExamApp
//
//  Created by OparinOleg on 02.06.2020.
//  Copyright © 2020 OparinOleg. All rights reserved.
//

import Foundation
import UIKit

class editViewController:UIViewController, UITextFieldDelegate, UITextViewDelegate{
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var costField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBOutlet weak var addButton: UIButton!
    
    let alert = UIAlertController(title: "Error", message: "Incorrect values!", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        costField.delegate = self
        descriptionField.delegate = self
        addButton.layer.cornerRadius = 15
        
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
    
    @IBAction func addBtnPressed(_ sender: Any) {
        if nameField.text! != "" && costField.text != "" && descriptionField.text! != "" && checkCost(cost: costField.text!){
            foodCore.save(nameField.text!, costField.text!, descriptionField.text!)
            descriptionField.text = ""
            costField.text = ""
            nameField.text = ""
        }
    }
    
    func checkCost(cost: String) -> Bool{
        
        for ch in cost{
            if ch >= "0" && ch <= "9"{
                continue
            }
            else{
                self.present(alert, animated: true)
                return false
            }
        }
        return true
    }
}
