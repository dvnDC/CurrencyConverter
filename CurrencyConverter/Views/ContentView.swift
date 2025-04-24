//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by Damian Cichosz on 19/04/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = CurrencyConverterViewModel()

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Convert")) {
                    HStack {
                        AmountInputView(amountText: $vm.amountText)
                        CurrencyPickerView(title: "From", currencies: vm.availableCurrencies, selection: $vm.baseCurrency)
                    }
                    CurrencyPickerView(title: "To", currencies: vm.availableCurrencies, selection: $vm.targetCurrency)
                }

                RateSectionView(rateLines: vm.rateText.lines)
                ConvertButtonView(isLoading: vm.isLoading) {
                    Task { await vm.convert() }
                }
                ErrorSectionView(errorMessage: vm.errorMessage)
                ResultSectionView(resultText: vm.resultText)
            }
            .navigationTitle("Currency Converter")
            .task { await vm.fetchRateText() }
            .onChange(of: vm.baseCurrency) { _ in Task { await vm.fetchRateText() } }
            .onChange(of: vm.targetCurrency) { _ in Task { await vm.fetchRateText() } }
        }
    }
}

#Preview {
    ContentView()
}
