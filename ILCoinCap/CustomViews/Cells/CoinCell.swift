//
//  CoinCell.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 23/1/24.
//

import UIKit

class CoinCell: UITableViewCell {
    
    let coinImageView = UIImageView(frame: .zero)
    let nameLabel = ILBodylabel(fontSize: 16, textAlignment: .left, textColor: .label)
    let symbolLabel = ILBodylabel(fontSize: 14, textAlignment: .left, textColor: .secondaryLabel)
    let priceUsdLabel = ILBodylabel(fontSize: 16, textAlignment: .right, textColor: .label)
    let changePercent24HrLabel = ILBodylabel(fontSize: 14, textAlignment: .right, textColor: .systemRed)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .clear
        addSubviews(coinImageView, nameLabel, symbolLabel, priceUsdLabel, changePercent24HrLabel)
        
        coinImageView.translatesAutoresizingMaskIntoConstraints = false
        coinImageView.layer.cornerRadius = 12
        coinImageView.backgroundColor = .systemGray6.withAlphaComponent(0.8)
        
        NSLayoutConstraint.activate([
            coinImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            coinImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            coinImageView.heightAnchor.constraint(equalToConstant: 48),
            
            nameLabel.topAnchor.constraint(equalTo: coinImageView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 19),
            
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            symbolLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 10),
            symbolLabel.heightAnchor.constraint(equalToConstant: 17),
            
            priceUsdLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            priceUsdLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            priceUsdLabel.heightAnchor.constraint(equalToConstant: 19),
            
            changePercent24HrLabel.topAnchor.constraint(equalTo: priceUsdLabel.bottomAnchor, constant: 2),
            changePercent24HrLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            changePercent24HrLabel.heightAnchor.constraint(equalToConstant: 17)
        ])
    }
    
    func set(coin: CoinInfo) {
        nameLabel.text = coin.name
        symbolLabel.text = coin.symbol
        priceUsdLabel.text = coin.priceUsd?.formatAsPriceUsd() ?? ""
        
        let changePercent24Hr = coin.changePercent24Hr?.formatChangePercentage() ?? ""
        
        if changePercent24Hr.hasPrefix("-") {
            changePercent24HrLabel.textColor = .systemRed
        } else {
            changePercent24HrLabel.textColor = .systemGreen
            changePercent24HrLabel.text = "+" + changePercent24Hr
            return
        }
        
        changePercent24HrLabel.text = changePercent24Hr
    }
}
