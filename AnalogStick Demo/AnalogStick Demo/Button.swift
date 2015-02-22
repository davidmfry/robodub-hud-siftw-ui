//
//  Button.swift
//  AnalogStick Demo
//
//  Created by David on 2/22/15.
//  Copyright (c) 2015 Dmitriy Mitrophanskiy. All rights reserved.
//

import SpriteKit

class Button: SKNode
{
    var tImage: UIImage!
    var buttonNode: SKSpriteNode!
    //self.buttonNode.texture = SKTexture(image: tImage)
    
    init (image: UIImage, buttonNode: SKSpriteNode )
    {
        super.init()
        self.tImage = image
        self.buttonNode = buttonNode
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}