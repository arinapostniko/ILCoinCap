//
//  ILButton.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 24/1/24.
//

import UIKit

class ILButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(image: SFSymbols) {
        self.init(frame: .zero)
        self.setImage(UIImage(systemName: image.rawValue), for: .normal)
    }
    
    private func configure() {
        layer.cornerRadius = 12
        backgroundColor = .clear
        tintColor = .label
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
