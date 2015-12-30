//
//  MainViewController.swift
//  RequestResponseDemo
//
//  Created by Andrew Madsen on 3/14/15.
//  Copyright (c) 2015 Open Reel Software. All rights reserved.
//
//	Permission is hereby granted, free of charge, to any person obtaining a
//	copy of this software and associated documentation files (the
//	"Software"), to deal in the Software without restriction, including
//	without limitation the rights to use, copy, modify, merge, publish,
//	distribute, sublicense, and/or sell copies of the Software, and to
//	permit persons to whom the Software is furnished to do so, subject to
//	the following conditions:
//	
//	The above copyright notice and this permission notice shall be included
//	in all copies or substantial portions of the Software.
//	
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//	CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Cocoa
import ORSSerial

class MainViewController: NSViewController {

	@IBOutlet weak var temperaturePlotView: TemperaturePlotView!
	let serialPortManager = SerialPortManager.sharedSerialPortManager
	let boardController = SerialBoardController()
	
	override func viewDidLoad() {
		self.boardController.addObserver(self, forKeyPath: "temperature", options: NSKeyValueObservingOptions(), context: MainViewControllerKVOContext)
	}
	
	// MARK: KVO
	
	let MainViewControllerKVOContext = UnsafeMutablePointer<()>()
	override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
		if context != MainViewControllerKVOContext {
			super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
		}
		
		if object as! NSObject == self.boardController && keyPath == "temperature" {
			self.temperaturePlotView.addTemperature(self.boardController.temperature)
		}
	}

}

