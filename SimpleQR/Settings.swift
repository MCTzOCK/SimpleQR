//
//  Settings.swift
//  SimpleQR
//
//  Created by Ben Siebert on 27.03.26.
//

import SwiftUI

fileprivate let MIT_LICENSE = """
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""

struct Settings: View {
    
    @AppStorage("defaultPixelShape") private var pixelShape: String = "blob"
    @AppStorage("defaultEyeShape") private var eyeShape: String = "bars-h"
    
    var libraries: [OpenSourceLibrary] = [
        OpenSourceLibrary(
            name: "QRCode",
            copyright: "Copyright (c) 2024 Darren Ford",
            licenseText: MIT_LICENSE
        ),
        OpenSourceLibrary(
            name: "swift-qrcode-generator",
            copyright: "Copyright (c) Project Nayuki. (MIT License) Copyright (c) 2020 fwcd",
            licenseText: MIT_LICENSE
        ),
        OpenSourceLibrary(
            name: "SwiftImageReadWrite",
            copyright: "Copyright (c) 2024 Darren Ford",
            licenseText: MIT_LICENSE
        )
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        VStack(spacing: 10) {
                            Image("Logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .shadow(radius: 5)
                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                            Text("SimpleQR")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("2.0")
                        }
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                }
                Section {
                    Link(destination: URL(string: "https://apps.apple.com/us/developer/ben-siebert/id1703019142")!) {
                        SettingsInfoRow(icon: "star.fill", color: .yellow, title: "More Apps by me :)", value: "")
                    }
                }
                Section("Legal") {
                    Link(destination: URL(string: "https://mctzock.github.io/ios-apps-pages/legal/notice")!) {
                        SettingsInfoRow(icon: "doc.text.fill", color: .blue, title: "Imprint / Legal Notice", value: "")
                    }
                    Link(destination: URL(string: "https://mctzock.github.io/ios-apps-pages/legal/privacy")!) {
                        SettingsInfoRow(icon: "doc.text.fill", color: .green, title: "Privacy Policy", value: "")
                    }
                    libraries.count > 0 ? (
                        NavigationLink {
                            LicenseViewer(libraries: libraries)
                        } label: {
                            SettingsInfoRow(icon: "books.vertical.fill", color: .indigo, title: "Open Source Licenses", value: "no-disclosure")
                        }
                    ) : nil
                }
            }
        }
    }
}

public struct SettingsInfoRow: View {
    public let icon: String
    public let color: Color
    public let title: LocalizedStringKey
    public let value: String
    
    @Environment(\.colorScheme) var colorScheme
    
    public init(icon: String, color: Color, title: LocalizedStringKey, value: String) {
        self.icon = icon
        self.color = color
        self.title = title
        self.value = value
    }
    
    public var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(color)
                .cornerRadius(6)
            
            Text(title)
                .font(.subheadline)
                .foregroundStyle(
                    colorScheme == .dark ? .white : .black
                )
            
            Spacer()
            value != "no-disclosure" ? Image(systemName: "chevron.right")
                .foregroundStyle(.gray.opacity(0.7))
                .font(.system(size: 14, weight: .semibold)) : nil
            
        }
    }
}
