//
//  SliderViewController.swift
//  Showcase App
//
//  Created by Kukina Anastasia on 23.11.2020.
//

import UIKit

class SliderViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var redValue: UITextField!
    @IBOutlet weak var greenValue: UITextField!
    @IBOutlet weak var blueValue: UITextField!
    
    var redColor: CGFloat = 1.0
    var greenColor: CGFloat = 1.0
    var blueColor: CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redValue.delegate = self
        greenValue.delegate = self
        blueValue.delegate = self
        
        redColor = CGFloat(redSlider.value)
        redValue.text = String(format: "%.0f", Float(redColor * 255.0))
        greenColor = CGFloat(redSlider.value)
        greenValue.text = String(format: "%.0f", Float(greenColor * 255.0))
        blueColor = CGFloat(redSlider.value)
        blueValue.text = String(format: "%.0f", Float(blueColor * 255.0))
        
        updateColor()
    }
    
    @IBAction func changeRed(_ sender: Any) {
        redColor = CGFloat(redSlider.value)
        redValue.text = String(format: "%.0f", Float(redColor * 255.0))
        updateColor()
    }
    
    @IBAction func changeGreen(_ sender: Any) {
        
        greenColor = CGFloat(greenSlider.value)
        greenValue.text = String(format: "%.0f", Float(greenColor * 255.0))
        updateColor()
    }
    
    @IBAction func changeBlue(_ sender: Any) {
        
        blueColor = CGFloat(blueSlider.value)
        blueValue.text = String(format: "%.0f", Float(blueColor * 255.0))
        updateColor()
    }
    
    func updateColor() {
        
        self.view.backgroundColor = UIColor(
            red: redColor,
            green: greenColor,
            blue: blueColor,
            alpha: 1.0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
        return true
    }
}
