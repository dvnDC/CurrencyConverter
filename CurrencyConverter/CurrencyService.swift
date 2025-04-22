//
//  CurrencyService.swift
//  CurrencyConverter
//
//  Created by Damian Cichosz on 19/04/2025.
//

import Foundation

/// Service responsible for fetching exchange rates from NBP API with simple in-memory caching
class CurrencyService {
    private var cache: [String: (rate: Double, date: Date)] = [:]
    private let cacheInterval: TimeInterval = 60 * 60  // Cache for 1 hour

    /// Fetches the mid rate for a given currency code (e.g. "USD").
    /// Uses cache when available and not expired.
    /// - Parameter code: Three-letter currency code
    /// - Returns: The mid exchange rate against PLN
    func fetchRate(for code: String) async throws -> Double {
        let now = Date()
        if let cached = cache[code], now.timeIntervalSince(cached.date) < cacheInterval {
            return cached.rate
        }
        let urlString = "https://api.nbp.pl/api/exchangerates/rates/A/\(code)?format=json"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let decoded = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
        guard let rate = decoded.rates.first else {
            throw NSError(domain: "No rates in response", code: 0)
        }
        cache[code] = (rate.mid, now)
        return rate.mid
    }
}
