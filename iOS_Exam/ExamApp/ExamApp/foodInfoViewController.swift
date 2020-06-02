//
//  foodInfoViewController.swift
//  ExamApp
//
//  Created by OparinOleg on 02.06.2020.
//  Copyright © 2020 OparinOleg. All rights reserved.
//

import Foundation
import UIKit

class foodInfoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    
    var name:String = ""
    var cost:String = ""
    var descrip: String = ""
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var costField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true);
        nameField.delegate = self
        costField.delegate = self
        descriptionField.delegate = self
        loadInfo()
    }
    
    @IBAction func viewAllBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "viewAll", sender: nil)
    }
    
    func loadInfo(){
        nameField.text = name
        costField.text = cost
        descriptionField.text = descrip
    }
}
