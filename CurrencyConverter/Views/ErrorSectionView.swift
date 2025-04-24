//
//  ErrorSectionView.swift
//  CurrencyConverter
//
//  Created by Damian Cichosz on 25/04/2025.
//

import SwiftUI

struct ErrorSectionView: View {
    let errorMessage: String?

    var body: some View {
        if let error = errorMessage {
            Section {
                Text(error)
                    .foregroundColor(.red)
            }
        }
    }
}
