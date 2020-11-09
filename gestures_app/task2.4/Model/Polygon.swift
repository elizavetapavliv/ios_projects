//
//  Polygon.swift
//  task2.4
//
//  Created by Elizaveta on 4/30/19.
//  Copyright © 2019 Elizaveta. All rights reserved.
//

import UIKit

@IBDesignable class Polygon: UIView {
    
    override func draw(_ rect: CGRect) {
        polygonPath()
    }
    
    func getRectangle() -> CGRect {
        let width = bounds.size.width/3.0 - 40.0
        let height = bounds.size.height - 40.0
        let diameter = max (min (width, height), 150.0)
        let rect = CGRect(x: 40.0, y: bounds.midY - 300, width: diameter, height: diameter)
        return rect
    }
    
    func polygonPath(){
        let rect = getRectangle()
        let path = UIBezierPath()
        let points = polygonPointArray(sides: 6, x: rect.midX, y: rect.midY + 230, radius: 80)
        let cpg = points[0]
        path.move(to: CGPoint(x: cpg.x, y: cpg.y))
        for p in points {
            path.addLine(to: CGPoint(x: p.x, y: p.y))
        }
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = UIColor.purple.cgColor
        
        let gradient = CAGradientLayer()
        gradient.frame = path.bounds
        gradient.bounds = path.bounds
        gradient.colors = [UIColor.purple.cgColor, UIColor.magenta.cgColor]
        let shapeMask = CAShapeLayer()
        shapeMask.path = path.cgPath
        gradient.mask = shapeMask
        
        let shadowLayer = CALayer()
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize.zero
        shadowLayer.shadowRadius = 10.0
        shadowLayer.shadowOpacity = 0.8
        shadowLayer.backgroundColor = UIColor.clear.cgColor
        
        shadowLayer.insertSublayer(shape, at: 0)
        shadowLayer.insertSublayer(gradient, at: 1)
        self.layer.addSublayer(shadowLayer)
    }
    
    func polygonPointArray(sides:Int,x:CGFloat,y:CGFloat,radius:CGFloat)->[CGPoint] {
        let angle = 2 * CGFloat(Double.pi) / CGFloat(sides)
        let cx = x
        let cy = y
        let r = radius
        var i = 0
        var points = [CGPoint]()
        while i <= sides {
            let xpo = cx + r * cos(angle * CGFloat(i))
            let ypo = cy + r * sin(angle * CGFloat(i))
            points.append(CGPoint(x: xpo, y: ypo))
            i += 1
        }
        return points
    }
}
