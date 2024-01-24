//
//  ILBackgroundView.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 24/1/24.
//

import UIKit

class ILBackgroundView: UIView {
    
    let ellipseOne = ILEllipseOne()
    let ellipseTwo = ILEllipseTwo()
    let ellipseThree = ILEllipseThree()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(ellipseOne, ellipseTwo, ellipseThree)
        
        ellipseOne.translatesAutoresizingMaskIntoConstraints = false
        ellipseTwo.translatesAutoresizingMaskIntoConstraints = false
        ellipseThree.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ellipseOne.widthAnchor.constraint(equalToConstant: 331),
            ellipseOne.heightAnchor.constraint(equalToConstant: 331),
            ellipseOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 174),
            ellipseOne.topAnchor.constraint(equalTo: topAnchor, constant: 437),
            
            ellipseTwo.widthAnchor.constraint(equalToConstant: 262),
            ellipseTwo.heightAnchor.constraint(equalToConstant: 262),
            ellipseTwo.leadingAnchor.constraint(equalTo: leadingAnchor),
            ellipseTwo.topAnchor.constraint(equalTo: topAnchor, constant: 256),
            
            ellipseThree.widthAnchor.constraint(equalToConstant: 262),
            ellipseThree.heightAnchor.constraint(equalToConstant: 262),
            ellipseThree.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 208),
            ellipseThree.topAnchor.constraint(equalTo: topAnchor, constant: 19)
        ])
    }
}
