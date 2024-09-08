//
//  Gen.swift
//  SimpleQR
//
//  Created by Ben Siebert on 08.09.24.
//

import Foundation
import QRCode
import SwiftUI

func genQR(code: QR) -> Data {
    
    let image = try? QRCode.build
        .text(code.url)
        .quietZonePixelCount(3)
        .foregroundColor(code.foregroundColor)
        .backgroundColor(code.backgroundColor)
        .background.cornerRadius(3)
        .onPixels.shape(code.pixelShape)
        .eye.shape(code.eyeShape)
        .generate.image(dimension: 600, representation: .png())
    
    if(image == nil) {
        return Data()
    }
    
    let x = UIImage(data: image!)
    
    if(x == nil) {
        return Data()
    }
    
    return x!.pngData()!
}
