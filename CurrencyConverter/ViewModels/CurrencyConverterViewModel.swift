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
    let availableCurrencies = ["PLN", "USD", "EUR", "GBP", "CHF", "CZK", "JPY"]

    @Published var baseCurrency: String = "USD"
    @Published var targetCurrency: String = "EUR"
    @Published var amountText: String = ""
    @Published var resultText: String = ""
    @Published var rateText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let service = CurrencyService()

    func convert() async {
        resultText = ""
        errorMessage = nil
        guard let amount = Double(amountText.replacingOccurrences(of: ",", with: ".")), amount > 0 else {
            errorMessage = "Please enter a valid number"
            return
        }
        isLoading = true
        defer { isLoading = false }
        do {
            let rateFrom = (baseCurrency == "PLN") ? 1.0 : try await service.fetchRate(for: baseCurrency)
            let rateTo   = (targetCurrency == "PLN") ? 1.0 : try await service.fetchRate(for: targetCurrency)
            let convertedValue = (amount * rateFrom) / rateTo
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
            let rateFrom = (baseCurrency == "PLN") ? 1.0 : try await service.fetchRate(for: baseCurrency)
            let rateTo   = (targetCurrency == "PLN") ? 1.0 : try await service.fetchRate(for: targetCurrency)
            let direct  = rateFrom / rateTo
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
            // ignore errors
        }
    }
}
