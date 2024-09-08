//
//  Item.swift
//  SimpleQR
//
//  Created by Ben Siebert on 08.09.24.
//

import Foundation
import CoreGraphics
import QRCode

final class QR {
    var url: String
    var foregroundColor: CGColor
    var backgroundColor: CGColor
    var pixelShape: QRCodePixelShapeGenerator
    var eyeShape: QRCodeEyeShapeGenerator
    
    init(url: String, foregroundColor: CGColor, backgroundColor: CGColor, pixelShape: QRCodePixelShapeGenerator, eyeShape: QRCodeEyeShapeGenerator) {
        self.url = url
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.pixelShape = pixelShape
        self.eyeShape = eyeShape
    }
}
