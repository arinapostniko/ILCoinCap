//
//  CoinCell.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 23/1/24.
//

import UIKit

class CoinCell: UITableViewCell {
    
    let coinImageView = UIImageView(frame: .zero)
    let idLabel = ILBodylabel(fontSize: 16, textAlignment: .left, textColor: .white)
    let symbolLabel = ILBodylabel(fontSize: 14, textAlignment: .left, textColor: .secondaryLabel)
    let priceUsdLabel = ILBodylabel(fontSize: 16, textAlignment: .right, textColor: .white)
    let changePercent24HrLabel = ILBodylabel(fontSize: 14, textAlignment: .right, textColor: .systemPink)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(coinImageView, idLabel, symbolLabel, priceUsdLabel, changePercent24HrLabel)
        
        coinImageView.translatesAutoresizingMaskIntoConstraints = false
        coinImageView.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            coinImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            coinImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            coinImageView.heightAnchor.constraint(equalToConstant: 48),
            coinImageView.widthAnchor.constraint(equalToConstant: 48),
            
            idLabel.topAnchor.constraint(equalTo: coinImageView.topAnchor, constant: 5),
            idLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 10),
            idLabel.heightAnchor.constraint(equalToConstant: 19),
            idLabel.widthAnchor.constraint(equalToConstant: 52),
            
            symbolLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 2),
            symbolLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 10),
            symbolLabel.heightAnchor.constraint(equalToConstant: 17),
            symbolLabel.widthAnchor.constraint(equalToConstant: 28),
            
            priceUsdLabel.topAnchor.constraint(equalTo: idLabel.topAnchor),
            priceUsdLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            priceUsdLabel.heightAnchor.constraint(equalToConstant: 19),
            priceUsdLabel.widthAnchor.constraint(equalToConstant: 92),
            
            changePercent24HrLabel.topAnchor.constraint(equalTo: priceUsdLabel.bottomAnchor, constant: 2),
            changePercent24HrLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            changePercent24HrLabel.heightAnchor.constraint(equalToConstant: 17),
            changePercent24HrLabel.widthAnchor.constraint(equalToConstant: 56)
        ])
    }
}
