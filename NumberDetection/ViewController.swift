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

	override func viewDidLoad() {
		super.viewDidLoad()
		paintView.delegate = self
	}

	func drawingEnded() {

	}

	@IBAction func clearButtonClicked(_ sender: UIButton) {
		paintView.image = UIImage()
	}
}

