//
//  ViewController.swift
//  NumberDetection
//
//  Created by Artem Bobrov on 23.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PaintViewDelegate{
	@IBOutlet weak var paintView: PaintView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		paintView.delegate = self
	}

	func drawingEnded(inPaintView paintView: PaintView) {
		
	}

}

