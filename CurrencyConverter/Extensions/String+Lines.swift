//
//  String+Lines.swift
//  CurrencyConverter
//
//  Created by Damian Cichosz on 25/04/2025.
//

import Foundation

extension String {
    /// Splits a multiline string into an array of lines
    var lines: [String] {
        components(separatedBy: "\n")
    }
}


