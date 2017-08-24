//
//  ViewController.swift
//  NumberDetection
//
//  Created by Artem Bobrov on 23.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, PaintViewDelegate{
	@IBOutlet weak var paintView: PaintView!

	let inputSize = CGSize(width: 28, height: 28)

	override func viewDidLoad() {
		super.viewDidLoad()
		paintView.delegate = self
	}

	func drawingEnded() {
		let mnist = MNIST()
		guard let input = mnist.preprocess(image: paintView.image!) else {
			print("preprocessing failed")
			return
		}

		guard let result = try? mnist.prediction(input: input) else {
			print("prediction failed")
			return
		}
		print(result.output)

	}
	@IBAction func clearButtonClicked(_ sender: UIButton) {
		paintView.image = UIImage()
	}
}

