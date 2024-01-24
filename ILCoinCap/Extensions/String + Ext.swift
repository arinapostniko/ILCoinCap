//
//  String + Ext.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 23/1/24.
//

import Foundation

extension String {
    
    func formatAsPriceUsd() -> String? {
        guard let priceValue = Double(self) else { return nil }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        
        guard var formattedPrice = formatter.string(from: NSNumber(value: priceValue)) else { return nil }
        
        formattedPrice = formattedPrice.replacingOccurrences(of: ",", with: " ")
        
        let finalString = "$ " + formattedPrice.replacingOccurrences(of: formatter.currencySymbol, with: "").trimmingCharacters(in: .whitespaces)

        return finalString
    }
    
    func formatChangePercentage() -> String? {
        if let doubleValue = Double(self) {
            return String(format: "%.2f%%", doubleValue)
        } else {
            return nil
        }
    }
    
    func formatMarketCap() -> String? {
        guard let marketCapValue = Double(self) else { return nil }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.currencySymbol = "$"
        
        let billion = 1_000_000_000.0
        let formattedMarketCap = marketCapValue / billion
        
        if let formattedString = formatter.string(from: NSNumber(value: formattedMarketCap)) {
            return "\(formattedString)b"
        } else {
            return nil
        }
    }
    
    func formatSupply() -> String? {
        guard let supplyValue = Double(self) else { return nil }
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        
        let million = 1_000_000.0
        let formattedSupply = supplyValue / million
        
        if let formattedString = formatter.string(from: NSNumber(value: formattedSupply)) {
            return "\(formattedString)m"
        } else {
            return nil
        }
    }
    
    func formatVolumeUsd24Hr() -> String? {
        guard let volumeValue = Double(self) else { return nil }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.currencySymbol = "$"
        
        let billion = 1_000_000_000.0
        let formattedVolume = volumeValue / billion
        
        if let formattedString = formatter.string(from: NSNumber(value: formattedVolume)) {
            return "\(formattedString)b"
        } else {
            return nil
        }
    }
    
    func formatChangePercent24Hr() -> String? {
        guard let floatValue = Float(self) else { return nil }

        let formattedValue = String(format: "%+.2f", floatValue * 100)
        let percentage = String(format: "%.2f%%", abs(floatValue) * 100)

        return "\(formattedValue) (\(percentage))"
    }
}
