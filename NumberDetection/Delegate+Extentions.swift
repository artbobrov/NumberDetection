//
//  Delegate+Extentions.swift
//  NumberDetection
//
//  Created by Artem Bobrov on 23.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import UIKit
import CoreML

protocol PaintViewDelegate {
	func drawingEnded()
}

extension UIImage{

	func resize(to newSize: CGSize) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(CGSize(width: newSize.width, height: newSize.height), true, 1.0)
		self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
		let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()

		return resizedImage
	}

	func pixelBuffer() -> CVPixelBuffer? {
		let w = self.size.width
		let h = self.size.height
		let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
		             kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
		var pixelBuffer: CVPixelBuffer?
		let s = CVPixelBufferCreate(kCFAllocatorDefault, Int(w), Int(h), kCVPixelFormatType_OneComponent8, attrs, &pixelBuffer)

		guard let resultPixelBuffer = pixelBuffer, s == kCVReturnSuccess else {return nil}

		CVPixelBufferLockBaseAddress(resultPixelBuffer, CVPixelBufferLockFlags(rawValue:0))
		let pixelData = CVPixelBufferGetBaseAddress(resultPixelBuffer)
		let grayColorSpace = CGColorSpaceCreateDeviceGray()
		guard let ctx = CGContext(data:pixelData, width: Int(w), height: Int(h), bitsPerComponent: 8,bytesPerRow: CVPixelBufferGetBytesPerRow(resultPixelBuffer), space: grayColorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue) else {
			return nil
		}
		ctx.translateBy(x: 0.0, y: h)
		ctx.scaleBy(x: 1.0, y: -1.0)
		UIGraphicsPushContext(ctx)
		self.draw(in: CGRect(x: 0.0, y: 0.0, width: w, height: h))
		UIGraphicsPopContext()
		CVPixelBufferUnlockBaseAddress(resultPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
		return resultPixelBuffer
	}

}
