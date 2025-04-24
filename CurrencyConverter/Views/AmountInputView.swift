//
//  AmountInputView.swift
//  CurrencyConverter
//
//  Created by Damian Cichosz on 25/04/2025.
//

import SwiftUI

struct AmountInputView: View {
    @Binding var amountText: String

    var body: some View {
        TextField("Amount", text: $amountText)
            .keyboardType(.decimalPad)
    }
}
