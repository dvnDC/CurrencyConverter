//
//  CurrencyPickerView.swift
//  CurrencyConverter
//
//  Created by Damian Cichosz on 25/04/2025.
//

import SwiftUI

struct CurrencyPickerView: View {
    let title: String
    let currencies: [String]
    @Binding var selection: String

    var body: some View {
        Picker(title, selection: $selection) {
            ForEach(currencies, id: \.self) { code in
                Text(code)
            }
        }
        .pickerStyle(.menu)
    }
}
