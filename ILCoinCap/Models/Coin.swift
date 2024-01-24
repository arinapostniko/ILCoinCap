//
//  Coin.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 23/1/24.
//

import Foundation

struct CoinData: Codable {
    let data: [CoinInfo]
}

struct CoinInfo: Codable {
    let name: String
    let symbol: String
    let priceUsd: String?
    let changePercent24Hr: String?
}
