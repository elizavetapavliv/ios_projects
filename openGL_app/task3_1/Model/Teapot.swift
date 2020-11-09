//
//  Teapot.swift
//  task3_1
//
//  Created by Elizaveta on 5/9/19.
//  Copyright © 2019 Elizaveta. All rights reserved.
//

import Foundation
import GLKit

class Teapot {
    static var Vertices = [
        Vertex(x:  1, y: -1, z: 0, r: 0, g: 0, b: 1, a: 1),
        Vertex(x:  1, y:  1, z: 0, r: 1, g: 0, b: 1, a: 1),
        Vertex(x: -1, y:  1, z: 0, r: 1, g: 0, b: 1, a: 1),
        Vertex(x: -1, y: -1, z: 0, r: 0, g: 0, b: 0, a: 1),
        
        Vertex(x:  1, y: -1, z: -1, r: 0, g: 0, b: 1, a: 1),
        Vertex(x:  1, y:  1, z: -1, r: 1, g: 0, b: 1, a: 1),
        Vertex(x: -1, y:  1, z: -1, r: 1, g: 0, b: 1, a: 1),
        Vertex(x: -1, y: -1, z: -1, r: 0, g: 0, b: 0, a: 1),
        
        Vertex(x:  0.5, y: -0.5, z: 0, r: 0, g: 0, b: 1, a: 1),
        Vertex(x:  0.5, y:  0.5, z: 0, r: 1, g: 0, b: 1, a: 1),
        Vertex(x: -0.5, y:  0.5, z: 0, r: 1, g: 0, b: 1, a: 1),
        Vertex(x: -0.5, y: -0.5, z: 0, r: 0, g: 0, b: 1, a: 1),
        Vertex(x:  0, y: 0, z: 0.5, r: 0, g: 1, b: 1, a: 1),
        ]
    
    static var Indices: [GLubyte] = [
        0, 1, 2,
        2, 3, 0,
        0, 4, 5,
        0, 1, 5,
        4, 7, 6,
        4, 5, 6,
        3, 7, 6,
        3, 2, 6,
        1, 5, 6,
        1, 6, 2,
        0, 4, 7,
        0, 7, 3,
        8, 12 ,11,
        11, 10, 12,
        12, 10, 9,
        9, 12, 8
    ]
}
