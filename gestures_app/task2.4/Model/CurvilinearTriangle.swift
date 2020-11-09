//
//  CurvilinearTriangle.swift
//  task2.4
//
//  Created by Elizaveta on 4/30/19.
//  Copyright © 2019 Elizaveta. All rights reserved.
//

import UIKit

@IBDesignable class CurvilinearTriangle: UIView {
    
    override func draw(_ rect: CGRect) {
        curvilinearTrianglePath()
    }
    
    func getRectangle() -> CGRect {
        let width = bounds.size.width/3.0 - 40.0
        let height = bounds.size.height - 40.0
        let diameter = max (min (width, height), 150.0)
        let rect = CGRect(x: 50.0, y: bounds.minY, width: diameter, height: diameter)
        return rect
    }
    
    func curvilinearTrianglePath () {
        let rect = getRectangle()
        let path = UIBezierPath()
        let center = CGPoint(x:rect.midX, y: rect.midY - 55.0)
        let radius = rect.size.width
        path.move(to: center)
        path.addArc(withCenter: center, radius: radius, startAngle: CGFloat(Double.pi/3), endAngle: CGFloat(2 * Double.pi/3), clockwise: true)
        path.addLine(to: center)
        path.close()
        
        let shadowLayer = CALayer()
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize.zero
        shadowLayer.shadowRadius = 10.0
        shadowLayer.shadowOpacity = 0.8
        shadowLayer.backgroundColor = UIColor.clear.cgColor
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = UIColor.blue.cgColor
        shape.fillColor = UIColor.cyan.cgColor
        
        shadowLayer.insertSublayer(shape, at: 0)
        self.layer.addSublayer(shadowLayer)
        
    }
    
}
