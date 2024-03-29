//
//  ILItemInfoView.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 24/1/24.
//

import UIKit

enum ItemInfoType { case marketCap, supply, volume24Hr }

class ILItemInfoView: UIView {
    
    let categoryNameLabel = ILBodylabel(fontSize: 12, textAlignment: .left, textColor: .secondaryLabel)
    let categoryInfoLabel = ILBodylabel(fontSize: 16, textAlignment: .left, textColor: .label)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(categoryNameLabel, categoryInfoLabel)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 35),
            widthAnchor.constraint(equalToConstant: 74),
            
            categoryNameLabel.topAnchor.constraint(equalTo: topAnchor),
            categoryNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryNameLabel.heightAnchor.constraint(equalToConstant: 14),
            
            categoryInfoLabel.topAnchor.constraint(equalTo: categoryNameLabel.bottomAnchor, constant: 2),
            categoryInfoLabel.leadingAnchor.constraint(equalTo: categoryNameLabel.leadingAnchor),
            categoryInfoLabel.heightAnchor.constraint(equalToConstant: 19)
        ])
    }
    
    func set(itemInfoType: ItemInfoType, with info: String) {
        switch itemInfoType {
        case .marketCap:
            categoryNameLabel.text = CategoriesNames.marketCap
            categoryInfoLabel.text = info.formatMarketCap()
        case .supply:
            categoryNameLabel.text = CategoriesNames.supply
            categoryInfoLabel.text = info.formatSupply()
        case .volume24Hr:
            categoryNameLabel.text = CategoriesNames.volume24Hr
            categoryInfoLabel.text = info.formatVolumeUsd24Hr()
        }
    }
}
