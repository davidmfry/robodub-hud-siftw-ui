//
//  GameScene.swift
//  stick test
//
//  Created by Dmitriy Mitrophanskiy on 28.09.14.
//  Copyright (c) 2014 Dmitriy Mitrophanskiy. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, AnalogStickProtocol {
    var appleNode: SKSpriteNode?
    var crossHair: SKSpriteNode?
    var fireButtton: SKSpriteNode?
    var reloadButton: SKSpriteNode?
    
    
    let moveAnalogStick: AnalogStick = AnalogStick()
    let rotateAnalogStick: AnalogStick = AnalogStick()
    
    override func didMoveToView(view: SKView)
    {
        /* Setup your scene here */
        let bgDiametr: CGFloat = 120
        let thumbDiametr: CGFloat = 60
        let joysticksRadius = bgDiametr / 2
        
        // Setup left joystick
        moveAnalogStick.bgNodeDiametr = bgDiametr
        moveAnalogStick.thumbNodeDiametr = thumbDiametr
        moveAnalogStick.position = CGPointMake(joysticksRadius + 15, joysticksRadius + 15)
        moveAnalogStick.delagate = self
        self.addChild(moveAnalogStick)
        
        // Setup right joystick
        rotateAnalogStick.bgNodeDiametr = bgDiametr
        rotateAnalogStick.thumbNodeDiametr = thumbDiametr
        rotateAnalogStick.position = CGPointMake(CGRectGetMaxX(self.frame) - joysticksRadius - 15, joysticksRadius + 15)
        rotateAnalogStick.delagate = self
        self.addChild(rotateAnalogStick)
        
        // Crosshair setup
        self.crossHair = SKSpriteNode(imageNamed: "crosshair-20")
        if let cHNode = self.crossHair {
            cHNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        }
        self.addChild(self.crossHair!)
        
        // Fire button
        self.fireButtton = SKSpriteNode(imageNamed: "firebutton-66")
        if let fbNode = self.fireButtton
        {
            fbNode.position = CGPointMake(170.0, 50.0)
        }
        self.addChild(self.fireButtton!)
        
        // Reload button
        self.reloadButton = SKSpriteNode(imageNamed: "reload-button")
        if let rbNode = self.reloadButton
        {
            rbNode.position = CGPointMake(400, 50.0)
        }
        self.addChild(self.reloadButton!)
        
        
        
        // apple
//        appleNode = SKSpriteNode(imageNamed: "apple")
//        if let aN = appleNode {
//            aN.physicsBody = SKPhysicsBody(texture: aN.texture, size: aN.size)
//            aN.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
//            aN.physicsBody?.affectedByGravity = false;
//            self.insertChild(aN, atIndex: 0)
//        }
//        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        //addOneApple()
    }
    
    func addOneApple()->Void {
        let appleNode = SKSpriteNode(imageNamed: "apple");
        appleNode.physicsBody = SKPhysicsBody(texture: appleNode.texture, size: appleNode.size)
        appleNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        appleNode.physicsBody?.affectedByGravity = false;
        self.addChild(appleNode)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        super.touchesBegan(touches, withEvent: event)
        if let touch = touches.anyObject() as? UITouch
        {
            var touchPos = touch.locationInNode(self)
            //appleNode?.position = touch.locationInNode(self)
            
            if self.nodeAtPoint(touchPos) == self.fireButtton
            {
                println("FIRE")
            }
            
            if self.nodeAtPoint(touchPos) == self.reloadButton
            {
                println("Reload")
            }
            
            
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    // MARK: AnalogStickProtocol
    func moveAnalogStick(analogStick: AnalogStick, velocity: CGPoint, angularVelocity: Float)
    {
        var velocityModifier = -4
        var velX = Int(velocity.x) * velocityModifier
        var velY = Int(velocity.y) * velocityModifier
        

        // Data for the left and right thumb stick
        if analogStick.isEqual(moveAnalogStick)
        {

            println("move stick data: \(velX), \(velY) ")
            
        }
        else if analogStick.isEqual(rotateAnalogStick)
        {
            println("rotate stick data: \(angularVelocity)")
        }
        
//        if let aN = appleNode {
//            if analogStick.isEqual(moveAnalogStick)
//            {
//                println("move stick: \(velocity)")
//                aN.position = CGPointMake(aN.position.x + (velocity.x * 0.12), aN.position.y + (velocity.y * 0.12))
//                //println("Apple location on screen \(aN.position)")
//            } else if analogStick.isEqual(rotateAnalogStick)
//            {
//                println("move stick: \(angularVelocity)")
//                aN.zRotation = CGFloat(angularVelocity)
//            }
//        }
    }
}
