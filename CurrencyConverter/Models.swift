//
//  Models.swift
//  CurrencyConverter
//
//  Created by Damian Cichosz on 19/04/2025.
//

import Foundation

/// Represents a single rate entry from NBP API
struct Rate: Codable {
    let no: String             // Rate number
    let effectiveDate: String  // Date of the rate
    let mid: Double            // Mid exchange rate
}

/// Top-level response from NBP API
struct ExchangeRateResponse: Codable {
    let table: String
    let currency: String
    let code: String
    let rates: [Rate]
}
