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
        addSubviews(coinImageView, nameLabel, symbolLabel, priceUsdLabel, changePercent24HrLabel)
        backgroundColor = .clear
        
        coinImageView.translatesAutoresizingMaskIntoConstraints = false
        coinImageView.layer.cornerRadius = 12
        coinImageView.backgroundColor = .systemGray6.withAlphaComponent(0.8)
        
        NSLayoutConstraint.activate([
            coinImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            coinImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            coinImageView.heightAnchor.constraint(equalToConstant: 48),
            coinImageView.widthAnchor.constraint(equalToConstant: 48),
            
            nameLabel.topAnchor.constraint(equalTo: coinImageView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 19),
            nameLabel.widthAnchor.constraint(equalToConstant: 92),
            
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            symbolLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 10),
            symbolLabel.heightAnchor.constraint(equalToConstant: 17),
            symbolLabel.widthAnchor.constraint(equalToConstant: 92),
            
            priceUsdLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            priceUsdLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            priceUsdLabel.heightAnchor.constraint(equalToConstant: 19),
            priceUsdLabel.widthAnchor.constraint(equalToConstant: 92),
            
            changePercent24HrLabel.topAnchor.constraint(equalTo: priceUsdLabel.bottomAnchor, constant: 2),
            changePercent24HrLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            changePercent24HrLabel.heightAnchor.constraint(equalToConstant: 17),
            changePercent24HrLabel.widthAnchor.constraint(equalToConstant: 92)
        ])
    }
    
    func set(coin: CoinInfo) {
        nameLabel.text = coin.name
        symbolLabel.text = coin.symbol
        priceUsdLabel.text = formatPrice(coin.priceUsd)
        changePercent24HrLabel.text = formatChangePercentage(coin.changePercent24Hr)
    }
    
    func formatPrice(_ priceString: String) -> String? {
        guard let priceValue = Double(priceString) else { return nil }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        
        guard let formattedPrice = formatter.string(from: NSNumber(value: priceValue)) else { return nil }
        
        let finalString = "$ " + formattedPrice.replacingOccurrences(of: formatter.currencySymbol, with: "").trimmingCharacters(in: .whitespaces)

        return finalString
    }
    
    func formatChangePercentage(_ changePercent24HrString: String) -> String? {
        if let changePercent24HrDouble = Double(changePercent24HrString) {
            let formattedPercent = String(format: "%.2f%%", changePercent24HrDouble)
            return formattedPercent
        } else {
            return nil
        }
    }
}
