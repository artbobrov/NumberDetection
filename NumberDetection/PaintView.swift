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
	}
}


