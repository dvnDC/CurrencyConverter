//
//  Rate.swift
//  CurrencyConverter
//
//  Created by Damian Cichosz on 25/04/2025.
//

import Foundation

/// Represents a single rate entry from NBP API
struct Rate: Codable {
    let no: String             // Rate number
    let effectiveDate: String  // Date of the rate
    let mid: Double            // Mid exchange rate
}
