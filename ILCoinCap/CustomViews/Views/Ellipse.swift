//
//  Ellipse.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 23/1/24.
//

import UIKit

class Ellipse: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 331, height: 331))
        backgroundView.backgroundColor = .clear
        backgroundView.layer.cornerRadius = 331

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = backgroundView.bounds
        gradientLayer.colors = [
            UIColor(red: 0.88, green: 0.2, blue: 0.99, alpha: 1.0).cgColor,
            UIColor(red: 0.56, green: 0.13, blue: 0.9, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

        backgroundView.layer.addSublayer(gradientLayer)

        addSubview(backgroundView)
    }
}
