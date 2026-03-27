//
//  ContentView.swift
//  SimpleQR
//
//  Created by Ben Siebert on 27.03.26.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Tab {
                Generator()
            } label: {
                Label("Generator", systemImage: "qrcode")
            }
            Tab {
                Settings()
            } label: {
                Label("Settings", systemImage: "gear")
            }
        }
    }
    
}
