//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Damian Cichosz on 19/04/2025.
//

import Foundation
import SwiftUI

@MainActor
class CurrencyConverterViewModel: ObservableObject {
    // Include PLN alongside other currencies
    let availableCurrencies = ["PLN", "USD", "EUR", "GBP", "CHF", "CZK", "JPY"]

    @Published var baseCurrency: String = "USD"      // Currency to convert from
    @Published var targetCurrency: String = "EUR"    // Currency to convert to
    @Published var amountText: String = ""           // User input amount as String
    @Published var resultText: String = ""           // Formatted conversion result
    @Published var rateText: String = ""             // Current rate display
    @Published var isLoading: Bool = false             // Loading state
    @Published var errorMessage: String? = nil         // Error message to display

    private let service = CurrencyService()

    /// Performs the currency conversion by fetching exchange rates or using cache
    func convert() async {
        // Reset previous state
        resultText = ""
        errorMessage = nil

        // Validate input amount
        guard let amount = Double(amountText.replacingOccurrences(of: ",", with: ".")), amount > 0 else {
            errorMessage = "Please enter a valid number"
            return
        }

        // Prevent multiple requests
        isLoading = true
        defer { isLoading = false }

        do {
            // Determine rates: PLN has implicit rate of 1
            let rateFrom: Double = (baseCurrency == "PLN") ? 1.0 : try await service.fetchRate(for: baseCurrency)
            let rateTo: Double = (targetCurrency == "PLN") ? 1.0 : try await service.fetchRate(for: targetCurrency)

            // Convert amount: amount_in_pln = amount * rateFrom; then to target = amount_in_pln / rateTo
            let convertedValue = (amount * rateFrom) / rateTo

            // Format result with two decimals
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2
            
            if let formatted = formatter.string(from: NSNumber(value: convertedValue)) {
                resultText = "\(formatted) \(targetCurrency)"
            } else {
                resultText = "Conversion error"
            }
        } catch {
            errorMessage = "Error fetching rates: \(error.localizedDescription)"
        }
    }
    
    func fetchRateText() async {
        rateText = ""
        do {
            
            let rateFrom: Double = (baseCurrency == "PLN") ? 1.0 : try await service.fetchRate(for: baseCurrency)
            let rateTo: Double = (targetCurrency == "PLN") ? 1.0 : try await service.fetchRate(for: targetCurrency)
            let direct = rateFrom / rateTo
            let inverse = rateTo / rateFrom
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 4

            var lines: [String] = []
            if let d = formatter.string(from: NSNumber(value: direct)) {
                lines.append("1 \(baseCurrency) = \(d) \(targetCurrency)")
            }
            if let inv = formatter.string(from: NSNumber(value: inverse)) {
                lines.append("1 \(targetCurrency) = \(inv) \(baseCurrency)")
            }
            rateText = lines.joined(separator: "\n")
        } catch {
            // ignore errors for rate display
        }
    }
}

