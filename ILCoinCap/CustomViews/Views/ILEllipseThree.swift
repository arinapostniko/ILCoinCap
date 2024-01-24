//
//  ILEllipseThree.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 24/1/24.
//

import UIKit

class ILEllipseThree: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 262, height: 262))
        backgroundView.backgroundColor = .clear
        backgroundView.layer.cornerRadius = 262
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = backgroundView.bounds
        gradientLayer.cornerRadius = backgroundView.frame.height / 2
        gradientLayer.colors = [
          UIColor(red: 0.196, green: 0.275, blue: 0.988, alpha: 1).cgColor,
          UIColor(red: 0.582, green: 0.267, blue: 0.898, alpha: 1).cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        backgroundView.layer.addSublayer(gradientLayer)
        
        addSubview(backgroundView)
    }
}
