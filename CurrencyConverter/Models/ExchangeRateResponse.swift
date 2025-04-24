//
//  ExchangeRateResponse.swift
//  CurrencyConverter
//
//  Created by Damian Cichosz on 25/04/2025.
//

/// Top-level response from NBP API
struct ExchangeRateResponse: Codable {
    let table: String
    let currency: String
    let code: String
    let rates: [Rate]
}
