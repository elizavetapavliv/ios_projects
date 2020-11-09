//
//  ViewController.swift
//  taak3_1
//
//  Created by Elizaveta on 5/9/19.
//  Copyright © 2019 Elizaveta. All rights reserved.
//

import UIKit
import GLKit

extension ViewController{
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.85, 0.85, 0.85, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        effect.prepareToDraw()
        
        glBindVertexArrayOES(vao);
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(Teapot.Indices.count), GLenum(GL_UNSIGNED_BYTE), nil)
        glBindVertexArrayOES(0)
    }
}

extension ViewController: GLKViewControllerDelegate{
    func glkViewControllerUpdate(_ controller: GLKViewController) {
        let aspect = fabsf(Float(view.bounds.size.width) / Float(view.bounds.size.height))
        let projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0), aspect, 4.0, 10.0)
        effect.transform.projectionMatrix = projectionMatrix
        
        var modelViewMatrix = GLKMatrix4MakeTranslation(0.0, 0.0, distance)
        modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(rotation), 0, 1, 0)
        effect.transform.modelviewMatrix = modelViewMatrix
        modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(rotationX), 1, 0, 0)
        effect.transform.modelviewMatrix = modelViewMatrix
    }
}

extension Array {
    func size () -> Int {
        return MemoryLayout<Element>.stride * self.count
    }
}

class ViewController: GLKViewController {
    private var context: EAGLContext?
    private var effect = GLKBaseEffect()
    private var rotation: Float = 0.0
    private var rotationX: Float = 0.0
    private var distance: Float = -6.0
    private var ebo = GLuint()
    private var vbo = GLuint()
    private var vao = GLuint()
    private var tapped = 0
    
    @IBAction func swipeLeft(_ sender: Any) {
        rotation -= 10
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        rotation += 10
    }
    
    
    @IBAction func swipeDown(_ sender: Any) {
        rotationX += 10
    }
    
    @IBAction func swipeUp(_ sender: Any) {
        rotationX -= 10
    }
    
    @IBAction func longPress(_ sender: Any) {
        if tapped % 2 == 0
        {
            distance += 1.0
        }
        else
        {
             distance -= 1.0
        }
        tapped += 1
    }
    
    
    deinit {
        tearDownGL()
    }
    
    private func setepGL(){
        context = EAGLContext(api: .openGLES3)
        
        EAGLContext.setCurrent(context)
        
        if let view = self.view as? GLKView, let conext = context {
            view.context = context!
            delegate = self
        }
        let vertexAttribColor = GLuint(GLKVertexAttrib.color.rawValue)
        let vertexAttribPosition = GLuint(GLKVertexAttrib.position.rawValue)
        let vertexSize = MemoryLayout<Vertex>.stride
        let colorOffset = MemoryLayout<GLfloat>.stride * 3
        let colorOffsetPointer = UnsafeRawPointer(bitPattern: colorOffset)
        glGenVertexArraysOES(1, &vao)
        glBindVertexArrayOES(vao)
        glGenBuffers(1, &vbo)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vbo)
        glBufferData(GLenum(GL_ARRAY_BUFFER),
            Teapot.Vertices.size(),
            Teapot.Vertices,           
            GLenum(GL_STATIC_DRAW))
        glEnableVertexAttribArray(vertexAttribPosition)
        glVertexAttribPointer(vertexAttribPosition,
            3,
            GLenum(GL_FLOAT),           
            GLboolean(UInt8(GL_FALSE)), 
            GLsizei(vertexSize),        
            nil)
        
        glEnableVertexAttribArray(vertexAttribColor)
        glVertexAttribPointer(vertexAttribColor,
                              4,
                              GLenum(GL_FLOAT),
                              GLboolean(UInt8(GL_FALSE)),
                              GLsizei(vertexSize),
                              colorOffsetPointer)
        glGenBuffers(1, &ebo)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), ebo)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER),
                     Teapot.Indices.size(),
                     Teapot.Indices,
                     GLenum(GL_STATIC_DRAW))
        glBindVertexArrayOES(0)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), 0)
    }
    
    private func tearDownGL() {
        EAGLContext.setCurrent(context)
        
        glDeleteBuffers(1, &vao)
        glDeleteBuffers(1, &vbo)
        glDeleteBuffers(1, &ebo)
        
        EAGLContext.setCurrent(nil)
        
        context = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setepGL()
    }
    
}
