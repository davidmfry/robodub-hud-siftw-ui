//
//  GameScene.swift
//  stick test
//
//  Created by Dmitriy Mitrophanskiy on 28.09.14.
//  Copyright (c) 2014 Dmitriy Mitrophanskiy. All rights reserved.
//  Modfied by David Fry on 2.21.15

import SpriteKit

class GameScene: SKScene, AnalogStickProtocol
{
    
    // Firebase Setup
    var ref = Firebase(url: "https://robodub.firebaseio.com")
//    var appleNode: SKSpriteNode?
    var bgImage: SKSpriteNode?
    var crossHair: SKSpriteNode?
    var fireButtton: SKSpriteNode?
    var reloadButton: SKSpriteNode?
    var weatherLabel:SKLabelNode!
    

    let moveAnalogStick: AnalogStick = AnalogStick()
    let rotateAnalogStick: AnalogStick = AnalogStick()
    
    override func didMoveToView(view: SKView)
    {
        /* Setup your scene here */
        let bgDiametr: CGFloat = 120
        let thumbDiametr: CGFloat = 60
        let joysticksRadius = bgDiametr / 2
        
        //self.getWeatherData()
        
        //Background
        var bgImage = SKSpriteNode(imageNamed: "appBG")
        bgImage.position = CGPointMake(self.size.width/2, self.size.height/2)
        
        self.addChild(bgImage)
        // Setup left joystick
        
        // Weather Label
        self.weatherLabel = SKLabelNode(fontNamed: "Helvetica Neue")
        self.weatherLabel.text = "Current Temp: \(self.getWeatherData())"
        self.weatherLabel.fontSize = 30
        //self.weatherLabel.color = UIColor.blackColor()
        self.weatherLabel.position = CGPointMake(100.0, 280.0)
        self.addChild(self.weatherLabel)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.weatherLabel.text = "Current Temp: \(self.getWeatherData())"
        })
        
        
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
        
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        super.touchesBegan(touches, withEvent: event)
        if let touch = touches.anyObject() as? UITouch
        {
            var touchPos = touch.locationInNode(self)
            
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
    
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
        
        
    }
    
    // MARK: AnalogStickProtocol
    func moveAnalogStick(analogStick: AnalogStick, velocity: CGPoint, angularVelocity: Float)
    {
        var velocityModifier = -4
        var velX = Int(velocity.x) * velocityModifier
        var velY = Int(velocity.y) * velocityModifier
        var rot = (Int(angularVelocity) * -251) * -1
        
        var dataRef = self.ref.childByAppendingPath("data")
        var data = ["5":"\(velX)", "6":"\(velY)","7":"\(rot)"]

        dataRef.updateChildValues(data)
        
    }
    
    func getNewImage() -> SKTexture
    {
        var url = NSURL(string: "https://robostream.blob.core.windows.net/robot/robot.jpg")
        var imageData = NSData(contentsOfURL: url!)
        var image = UIImage(data: imageData!)
        var imageTexture = SKTexture(image: image!)
        
        return imageTexture
    }
    
    func getWeatherData() -> String
    {
        let url = NSURL(string: "https://robostream.blob.core.windows.net/robot/temp.data")
        var weatherData: NSString = ""
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
                weatherData = NSString(data: data, encoding: NSUTF8StringEncoding)!
            self.weatherLabel.text = "Seattle: \(weatherData)f"
        }
        task.resume()
        return weatherData

    }
    
    

}
