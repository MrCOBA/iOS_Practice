//
//  RainbowView.swift
//  Blur App
//
//  Created by Kukina Anastasia on 20.01.2021.
//

import UIKit

class RainbowView: UIView {
    
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    override func draw(_ rect: CGRect) {
        
        let colors = [UIColor.red.cgColor,
                      UIColor.orange.cgColor,
                      UIColor.yellow.cgColor,
                      UIColor.green.cgColor,
                      UIColor.cyan.cgColor,
                      UIColor.blue.cgColor,
                      UIColor.purple.cgColor]
        
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds
        gradientLayer.opacity = 0.3
        
        layer.insertSublayer(gradientLayer, at: 0)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
    }
}
