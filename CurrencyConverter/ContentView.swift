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
                        TextField("Amount", text: $vm.amountText)
                            .keyboardType(.decimalPad)
                        Picker("From", selection: $vm.baseCurrency) {
                            ForEach(vm.availableCurrencies, id: \.self) { code in
                                Text(code)
                            }
                        }
                    }

                    Picker("To", selection: $vm.targetCurrency) {
                        ForEach(vm.availableCurrencies, id: \.self) { code in
                            Text(code)
                        }
                    }
                }

                if !vm.rateText.isEmpty {
                        Section(header: Text("Rate")) {
                            Text(vm.rateText)
                        }
                    }

                Section {
                    Button(action: {
                        Task { await vm.convert() }
                    }) {
                        if vm.isLoading {
                            ProgressView()
                        } else {
                            Text("Convert")
                        }
                    }
                    .disabled(vm.isLoading)
                }

                if let error = vm.errorMessage {
                    Section {
                        Text(error)
                            .foregroundColor(.red)
                    }
                }

                if !vm.resultText.isEmpty {
                    Section(header: Text("Result")) {
                        Text(vm.resultText)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                }
            }
            .navigationTitle("Currency Converter")
            .onAppear { Task { await vm.fetchRateText() } }
            .onChange(of: vm.baseCurrency) { Task { await vm.fetchRateText() } }
            .onChange(of: vm.targetCurrency) { Task { await vm.fetchRateText() } }
        }
    }
}

#Preview {
    ContentView()
}

