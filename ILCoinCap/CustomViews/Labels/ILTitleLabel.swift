//
//  ILTitleLabel.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 24/1/24.
//

import UIKit

class ILTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        textColor = .label
        textAlignment = .left
        font = UIFont(name: "Gonzi Expanded PERSONAL USE Bold", size: 24)
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
