//
//  ViewController.swift
//  task2.4
//
//  Created by Elizaveta on 4/30/19.
//  Copyright © 2019 Elizaveta. All rights reserved.
//

import UIKit

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.view != otherGestureRecognizer.view {
            return false;
        }
        if (gestureRecognizer is UIPanGestureRecognizer && otherGestureRecognizer is UIRotationGestureRecognizer) ||
            (gestureRecognizer is UIRotationGestureRecognizer && otherGestureRecognizer is UIPanGestureRecognizer) {
            return true;
        }
        return false
    }
}

class ViewController: UIViewController {

    @IBOutlet var polygon: Polygon!
    var used = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func changeBackground (name: String,recognizer: UIGestureRecognizer) {
        if let view = recognizer.view {
            let shadow = view.layer.sublayers?.popLast()
            var shape = shadow?.sublayers?.popLast()
            if  (recognizer.view?.isEqual(polygon))! && !used {
                shape = shadow?.sublayers?.popLast()
                used = true
            }
            let lShape = CAShapeLayer()
            lShape.path = (shape as! CAShapeLayer).path
            lShape.fillColor = UIColor(patternImage: UIImage(imageLiteralResourceName: name)).cgColor
            shadow?.insertSublayer(lShape, at: 0)
            view.layer.addSublayer(shadow!)
        }
    }
    
    @IBAction func handleTap(recognizer: UITapGestureRecognizer) {
        changeBackground(name: "bg3.jpg", recognizer: recognizer)
    }
    
    @IBAction func handleSwipe(recognizer: UISwipeGestureRecognizer) {
        changeBackground(name: "bg5.jpg", recognizer: recognizer)
    }
    
    @IBAction func handlePinch(recognizer: UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
        changeBackground(name: "bg2.jpg", recognizer: recognizer)
    }
    
    @IBAction func handleRotation(recognizer: UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
        changeBackground(name: "bg1.jpg", recognizer: recognizer)
    }
    
    @IBAction func handleLongPress (recognizer: UILongPressGestureRecognizer) {
        changeBackground(name: "bg4.jpg", recognizer: recognizer)
    }
}
