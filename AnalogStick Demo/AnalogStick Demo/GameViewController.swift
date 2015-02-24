//
//  GameViewController.swift
//  stick test
//
//  Created by Dmitriy Mitrophanskiy on 28.09.14.
//  Copyright (c) 2014 Dmitriy Mitrophanskiy. All rights reserved.
//  Modfied by David Fry on 2.21.15

import UIKit
import SpriteKit
import MediaPlayer

class GameViewController: UIViewController
{

    var moviePlayer: MPMoviePlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure the view.
        let scene = GameScene(size: self.view.bounds.size)
        var streamUrl = NSURL(string: "http://192.168.128.214:8080")
        self.moviePlayer = MPMoviePlayerController(contentURL: streamUrl)
        self.moviePlayer.view.frame = CGRect(x: 20, y: 100, width: 200, height: 150)
        
        //self.view.addSubview(moviePlayer.view)
        
        scene.backgroundColor = .whiteColor()
        let skView = self.view as SKView
        
        skView.showsFPS = false
        skView.showsNodeCount = false
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        /* Set the scale mode to scale to fit the window */
        //scene.scaleMode = .AspectFill
        skView.presentScene(scene)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
