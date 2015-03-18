//
//  ViewController.swift
//  FirstGame
//
//  Created by Felix Parker on 3/16/15.
//  Copyright (c) 2015 Felix Parker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = NSTimer()
    var lastColor = 0
    var currentColor = 5
    
    var score = 0
    
    let BLUE = 0
    let GREEN = 1
    let RED = 2
    let ORANGE = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeColor()
        resetTimer()
    }
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func swipeUp(sender: UISwipeGestureRecognizer) {
        
        if (currentColor == BLUE) {
            println("CORRECT")
            score++
            
            changeColor()
            resetTimer()
        } else {
            gameLost()
        }
        
    }
    
    @IBAction func swipeDown(sender: UISwipeGestureRecognizer) {
        
        if (currentColor == GREEN) {
            println("CORRECT")
            score++
            
            changeColor()
            resetTimer()
        } else {
            gameLost()
        }
        
    }
    
    @IBAction func swipeLeft(sender: UISwipeGestureRecognizer) {
        
        if (currentColor == RED) {
            println("CORRECT")
            score++
            
            changeColor()
            resetTimer()
        } else {
            gameLost()
        }
        
    }
    
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        
        if (currentColor == ORANGE) {
            println("CORRECT")
            score++
            
            changeColor()
            resetTimer()
        } else {
            gameLost()
        }

    }
    
    func changeColor() {
        var c = Int(arc4random_uniform(4)) // picks a random number 0-3
        var color : UIColor
        
        //make sure that it does not choose the same color twice in a row
        if (c == lastColor) {
            if (c < 3) {
                c++
            } else {
                c--
            }
        }
        
        //takes the random number and uses it to pick a color
        switch c {
        case BLUE:
            color = UIColor.blueColor()
        case GREEN:
            color = UIColor.greenColor()
        case RED:
            color = UIColor.redColor()
        case ORANGE:
            color = UIColor.orangeColor()
        default:
            color = UIColor.whiteColor()
        }
        
        mainView.backgroundColor = color //sets the background color to the random color
        currentColor = c
        lastColor = c
    }
    
    func gameLost() {
        println("GAME OVER")
        self.performSegueWithIdentifier("game_over", sender: self)
    }
    
    func resetTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("gameLost"), userInfo: nil, repeats: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

