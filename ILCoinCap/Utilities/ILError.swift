//
//  ILError.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 23/1/24.
//

import Foundation

enum ILError: String, Error {
    case invalidUrl = "This URL created a bad request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
