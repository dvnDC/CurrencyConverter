//
//  String+Lines.swift
//  CurrencyConverter
//
//  Created by Damian Cichosz on 25/04/2025.
//

import Foundation

extension String {
    /// Returns the emoji flag for a 2-letter country code.
    /// If code is 3 letters (e.g. "USD"), uses first two letters.
    var flag: String {
        let code = String(self.prefix(2)).uppercased()
        let base: UInt32 = 127397
        var flagString = ""
        for scalar in code.unicodeScalars {
            if let uni = UnicodeScalar(base + scalar.value) {
                flagString.unicodeScalars.append(uni)
            }
        }
        return flagString
    }
}
