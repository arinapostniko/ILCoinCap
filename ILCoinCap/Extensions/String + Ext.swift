//
//  String + Ext.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 23/1/24.
//

import Foundation

extension String {
    
    func formatAsCurrency() -> String? {
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
}
