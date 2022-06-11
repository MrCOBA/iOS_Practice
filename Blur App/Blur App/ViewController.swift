//
//  ViewController.swift
//  Blur App
//
//  Created by Kukina Anastasia on 20.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var smileView: RainbowView!
    @IBOutlet weak var smileImageView: UIImageView!
    @IBOutlet weak var pressMeButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    var blurEffectView: UIVisualEffectView?
    var selectedImageIndex = 0
    let imageSet = ["cloud", "coffee", "food", "pmq", "temple"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        smileImageView.layer.cornerRadius = 10
        smileImageView.layer.opacity = 0.5
        
        pressMeButton.layer.cornerRadius = 5
        pressMeButton.layer.shadowColor = UIColor.black.cgColor
        pressMeButton.layer.shadowRadius = 5
        pressMeButton.layer.shadowOffset = .zero
        pressMeButton.layer.shadowOpacity = 0.5
        
        selectedImageIndex = Int(arc4random_uniform(5))
        // Apply blurring effect
        backgroundImageView.image = UIImage(named: imageSet[selectedImageIndex])
        let blurEffect = UIBlurEffect(style: .light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        smileView.gradientLayer.frame = smileView.bounds
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        blurEffectView?.frame = view.bounds
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        selectedImageIndex = (selectedImageIndex + 1) % 5
        // Apply blurring effect
        backgroundImageView.image = UIImage(named: imageSet[selectedImageIndex])
    }
}

