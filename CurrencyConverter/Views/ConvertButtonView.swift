//
//  ConvertButtonView.swift
//  CurrencyConverter
//
//  Created by Damian Cichosz on 25/04/2025.
//

import SwiftUI

struct ConvertButtonView: View {
    let isLoading: Bool
    let action: () -> Void

    var body: some View {
        Section {
            Button(action: action) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Convert")
                }
            }
            .disabled(isLoading)
        }
    }
}
