//
//  ContentView.swift
//  SimpleQR
//
//  Created by Ben Siebert on 08.09.24.
//

import SwiftUI
import QRCode
import CoreGraphics
import StoreKit

struct Generator: View {
    
    @Environment(\.requestReview) private var requestReview
    
    @State private var url: String = ""
    @State private var foregroundColor: Color = Color(red: 0, green: 0, blue: 0)
    @State private var backgroundColor: Color = Color(red: 255, green: 255, blue: 255)
    @AppStorage("defaultPixelShape") private var pixelShape: String = "blob"
    @AppStorage("defaultEyeShape") private var eyeShape: String = "bars-h"
    @State private var imageData: Data?
    
    var body: some View {
        VStack {
            List {
                Section("Metadata") {
                    LabeledContent {
                        TextField("URL", text: $url)
                            .keyboardType(.URL)
                            .textContentType(.URL)
                            .autocorrectionDisabled()
                    } label: {
                        Text("URL")
                    }
                    ColorPicker("Foreground Color", selection: $foregroundColor)
                    ColorPicker("Background Color", selection: $backgroundColor)
                    Picker("Pixel-Shape", selection: $pixelShape) {
                        Text("Blob").tag("blob")
                        Text("square").tag("square")
                        Text("Circle").tag("circle")
                        Text("CurvePixel").tag("curvePixel")
                        Text("Horizontal").tag("horizontal")
                        Text("Squircle").tag("squircle")
                    }
                    Picker("Eye-Shape", selection: $eyeShape) {
                        Text("Bars-Horizontal").tag("bars-h")
                        Text("Bars-Vertical").tag("bars-v")
                        Text("Circle").tag("circle")
                        Text("Fireball").tag("fireball")
                        Text("Leaf").tag("leaf")
                        Text("Pinch").tag("pinch")
                        Text("Rounded-Rect").tag("roundedRect")
                        Text("Square").tag("square")
                        Text("Ufo").tag("ufo")
                    }
                    Button {
                        var pxShape: QRCodePixelShapeGenerator = QRCode.PixelShape.Blob()
                        var eyShape: QRCodeEyeShapeGenerator = QRCode.EyeShape.BarsHorizontal();
                        
                        if(pixelShape == "circle") {
                            pxShape = QRCode.PixelShape.Circle()
                        } else if(pixelShape == "square") {
                            pxShape = QRCode.PixelShape.Square()
                        } else if(pixelShape == "curvePixel") {
                            pxShape = QRCode.PixelShape.CurvePixel()
                        } else if(pixelShape == "horizontal") {
                            pxShape = QRCode.PixelShape.Horizontal()
                        } else if(pixelShape == "squircle") {
                            pxShape = QRCode.PixelShape.Squircle(rotationFraction: 1, useRandomRotation: true)
                        }
                        
                        if(eyeShape == "bars-v") {
                            eyShape = QRCode.EyeShape.BarsVertical();
                        } else if(eyeShape == "circle") {
                            eyShape = QRCode.EyeShape.Circle();
                        } else if(eyeShape == "fireball") {
                            eyShape = QRCode.EyeShape.Fireball();
                        } else if(eyeShape == "leaf") {
                            eyShape = QRCode.EyeShape.Leaf();
                        } else if(eyeShape == "pinch") {
                            eyShape = QRCode.EyeShape.Pinch();
                        } else if(eyeShape == "roundedRect") {
                            eyShape = QRCode.EyeShape.RoundedRect();
                        } else if(eyeShape == "square") {
                            eyShape = QRCode.EyeShape.Square();
                        } else if(eyeShape == "ufo") {
                            eyShape = QRCode.EyeShape.UFO();
                        }
                        
                        let qr = QR(url: url, foregroundColor: foregroundColor.cgColor!, backgroundColor: backgroundColor.cgColor!, pixelShape: pxShape, eyeShape: eyShape)
                        imageData = genQR(code: qr)
                        
                        requestReview()
                    } label: {
                        Label("Generate", systemImage: "play")
                    }
                    if(imageData != nil) {
                        let img = Image(
                            uiImage: UIImage(data: imageData!)!
                        )
                        img
                            .interpolation(.none)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        ShareLink(item: img, preview: SharePreview("QR-Code", image: img))
                    }
                }
            }
        }
    }
    
    private func presentReview() {
        Task {
            // Delay for two seconds to avoid interrupting the person using the app.
            try await Task.sleep(for: .seconds(2))
            await requestReview()
        }
    }
}
