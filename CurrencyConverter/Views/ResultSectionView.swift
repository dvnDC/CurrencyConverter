//
//  ResultSectionView.swift
//  CurrencyConverter
//
//  Created by Damian Cichosz on 25/04/2025.
//

import SwiftUI

struct ResultSectionView: View {
    let resultText: String

    var body: some View {
        if !resultText.isEmpty {
            Section(header: Text("Result")) {
                Text(resultText)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
        }
    }
}
