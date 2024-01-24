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
    var priceUsd: String?
    var changePercent24Hr: String?
    var marketCapUsd: String?
    var supply: String?
    var volumeUsd24Hr: String?
}
