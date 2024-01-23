//
//  ILBodylabel.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 23/1/24.
//

import UIKit

class ILBodylabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat, textAlignment: NSTextAlignment, textColor: UIColor) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
        self.textAlignment = textAlignment
        self.textColor = textColor
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
    }
}
