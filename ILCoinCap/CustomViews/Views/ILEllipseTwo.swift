//
//  ILEllipseTwo.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 24/1/24.
//

import UIKit

class ILEllipseTwo: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 131, height: 262))
        backgroundView.backgroundColor = .clear
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = backgroundView.bounds
        gradientLayer.cornerRadius = backgroundView.frame.width
        gradientLayer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        gradientLayer.colors = [
          UIColor(red: 0.988, green: 0.471, blue: 0.196, alpha: 1).cgColor,
          UIColor(red: 0.898, green: 0.267, blue: 0.588, alpha: 1).cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        backgroundView.layer.addSublayer(gradientLayer)
        
        addSubview(backgroundView)
    }
}
