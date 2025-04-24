//
//  RateSectionView.swift
//  CurrencyConverter
//
//  Created by Damian Cichosz on 25/04/2025.
//

import SwiftUI

struct RateSectionView: View {
    let rateLines: [String]

    var body: some View {
        if !rateLines.isEmpty {
            Section(header: Text("Rate")) {
                ForEach(rateLines, id: \.self) { line in
                    Text(line)
                }
            }
        }
    }
}
