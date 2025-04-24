//
//  WelcomeView.swift
//  CurrencyConverter
//
//  Created by Damian Cichosz on 25/04/2025.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()
                Text("Welcome to Currency Converter!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                NavigationLink(destination: ContentView()) {
                    Text("Process to converter")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    WelcomeView()
}
