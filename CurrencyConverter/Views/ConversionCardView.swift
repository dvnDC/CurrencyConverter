import SwiftUI

struct ConversionCardView: View {
    @StateObject private var vm = CurrencyConverterViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Text("Konwerter walut")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)

                VStack(spacing: 20) {
                    // Input Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Wartość")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        HStack {
                            Text(vm.baseCurrency.flag)
                                .font(.largeTitle)
                            Picker("", selection: $vm.baseCurrency) {
                                ForEach(vm.availableCurrencies, id: \.self) { code in
                                    Text(code)
                                }
                            }
                            .pickerStyle(.menu)
                            .frame(maxWidth: 80)
                            Spacer()
                            TextField("0", text: $vm.amountText)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 100)
                        }
                    }

                    // Swap Button (now in place of Convert)
                    Button(action: {
                        let temp = vm.baseCurrency
                        vm.baseCurrency = vm.targetCurrency
                        vm.targetCurrency = temp
                        Task {
                            await vm.convert()
                            await vm.fetchRateLines()
                        }
                    }) {
                        Image(systemName: "arrow.up.arrow.down.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }

                    // Output Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Przeliczona wartość")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        HStack {
                            Text(vm.targetCurrency.flag)
                                .font(.largeTitle)
                            Picker("", selection: $vm.targetCurrency) {
                                ForEach(vm.availableCurrencies, id: \.self) { code in
                                    Text(code)
                                }
                            }
                            .pickerStyle(.menu)
                            .frame(maxWidth: 80)
                            Spacer()
                            Text(vm.resultText)
                                .font(.headline)
                        }
                    }

                    // Convert Button below output
                    Button(action: {
                        Task {
                            await vm.convert()
                            await vm.fetchRateLines()
                        }
                    }) {
                        Text("Convert")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    // Exchange Rates
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(vm.rateLines, id: \.self) { line in
                            Text(line)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        if let error = vm.errorMessage {
                            Text(error)
                                .font(.footnote)
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemBackground)))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding()

                Spacer()
            }
            .navigationBarHidden(true)
            .task {
                await vm.fetchRateLines()
            }
        }
    }
}



#Preview {
    ConversionCardView()
}
