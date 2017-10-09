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
	@IBOutlet weak var inputImage: UIImageView!

	@IBOutlet weak var predictionLabel: UILabel!
	@IBOutlet weak var previewImage: UIImageView!

	let model = MNIST()

	override func viewDidLoad() {
		super.viewDidLoad()
		paintView.delegate = self
		previewImage.isHidden = true
	}

	func drawingEnded() {
		if let imgpixbuf = paintView.image?.resize(to: CGSize(width: 28.0, height: 28.0)).pixelBuffer(){
			previewImage.isHidden = false
			predictionLabel.isHidden = false
			previewImage.image = UIImage(ciImage: CIImage(cvImageBuffer: imgpixbuf))
			let prediction = try? self.model.prediction(image: imgpixbuf)
			guard let predictionValue = prediction else {
				self.predictionLabel.text = ""
				return
			}
			self.predictionLabel.text = "It is \(predictionValue.classLabel) with confidence \(predictionValue.prediction[predictionValue.classLabel] ?? -1)"
		}
	}

	@IBAction func clearButtonClicked(_ sender: UIButton) {
		paintView.image = UIImage()
		previewImage.isHidden = true
		predictionLabel.isHidden = true
	}
}

