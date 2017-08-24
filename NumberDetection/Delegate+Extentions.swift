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

extension UIImage {

	func resize(to newSize: CGSize) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(CGSize(width: newSize.width, height: newSize.height), true, 1.0)
		self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
		let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()

		return resizedImage
	}

	func pixelData() -> [UInt8]? {
		let dataSize = size.width * size.height * 4
		var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let context = CGContext(data: &pixelData, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 4 * Int(size.width), space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)

		guard let cgImage = self.cgImage else { return nil }
		context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: 28, height: 28))

		return pixelData
	}
}


extension MNIST {
	
	func preprocess(image: UIImage) -> MLMultiArray? {
		let size = CGSize(width: 28, height: 28)
		guard let pixels = image.resize(to: size).pixelData()?.map({ Float32($0) / 255.0 }) else {
			return nil
		}

		guard let array = try? MLMultiArray(shape: [1, 1, 784], dataType: .float32) else {
			return nil
		}

		let r = pixels.enumerated().filter { $0.offset % 4 == 0 }.map { $0.element }
		let g = pixels.enumerated().filter { $0.offset % 4 == 1 }.map { $0.element }
		let b = pixels.enumerated().filter { $0.offset % 4 == 2 }.map { $0.element }
		// FIXME: bad output(totally wrong), mb grayscale failed
		for index in 0..<28 * 28 {
			array[index] =  NSNumber(value: Float(0.3 * r[index]) + Float(0.59 * g[index]) + Float(0.11 * b[index]))
		}
		return array
	}
}
