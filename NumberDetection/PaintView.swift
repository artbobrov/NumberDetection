//
//  PaintView.swift
//  NumberDetection
//
//  Created by Artem Bobrov on 23.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import UIKit

class PaintView: UIImageView {
	var location: CGPoint!
	var delegate: PaintViewDelegate?


	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}


	private func commonInit() {
//		self.backgroundColor = .white
	}
//	override func draw(_ rect: CGRect) {
//		super.draw(rect)
//		self.backgroundColor = .white
//	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else {
			return
		}
		self.location = touch.location(in: self)
	}


	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else {
			return
		}
		let currentLocation = touch.location(in: self)
		UIGraphicsBeginImageContext(self.frame.size)
		let context = UIGraphicsGetCurrentContext()
		self.image?.draw(in: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
		context?.setLineCap(CGLineCap.round)
		context?.setLineWidth(8.0)
		context?.setStrokeColor(UIColor.white.cgColor)
		context?.beginPath()
		context?.move(to: location)
		context?.addLine(to: currentLocation)
		context?.strokePath()
		self.image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		location = currentLocation;
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else {
			return
		}
		let currentLocation = touch.location(in: self)
		UIGraphicsBeginImageContext(self.frame.size)
		let context = UIGraphicsGetCurrentContext()

		self.image?.draw(in: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))

		context?.setLineCap(CGLineCap.square)
		context?.setLineWidth(8.0)
		context?.setStrokeColor(UIColor.white.cgColor)
		context?.beginPath()
		context?.move(to: location)
		context?.addLine(to: currentLocation)
		context?.strokePath()
		self.image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		location = currentLocation;
		delegate?.drawingEnded()
	}


	func getViewContext() -> CGContext? {
		let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceGray()
		let bitmapInfo = CGImageAlphaInfo.none.rawValue
		guard let context = CGContext(data: nil,
		                              width: 28,
		                              height: 28,
		                              bitsPerComponent: 8,
		                              bytesPerRow: 28,
		                              space: colorSpace,
		                              bitmapInfo: bitmapInfo)
			else {
				fatalError("Could not get context")
		}

		context.translateBy(x: 0 , y: 28)
		context.scaleBy(x: 28/self.frame.size.width, y: -28/self.frame.size.height)

		self.layer.render(in: context)

		return context
	}
}


