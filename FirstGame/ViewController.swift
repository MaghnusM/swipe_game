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
    var difficulty = 3.0
    
    let BLUE = 0
    let GREEN = 1
    let RED = 2
    let ORANGE = 3
    
    var backgroundView = UIView()
    
    var arrow = UIImage(named: "arrow")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstChangeColor()
        //changeColor()
        resetTimer()
    }
    
    @IBOutlet var mainView: UIView!
    
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
                c-=2
            }
        }
        
        //takes the random number and uses it to pick a color
        switch c {
        case BLUE:
            color = UIColor(red: 0.15, green: 0.32, blue: 0.7, alpha: 1.0)
        case GREEN:
            color = UIColor(red: 0, green: 0.8, blue: 0.4, alpha: 1.0)
        case RED:
            color = UIColor(red: 1.0, green: 0.16, blue: 0.24, alpha: 1.0)
        case ORANGE:
            color = UIColor(red: 1.0, green: 0.43, blue: 0.2, alpha: 1.0)
        default:
            color = UIColor.whiteColor()
        }
        
        let screen = UIScreen.mainScreen().bounds // gets the constraints of the screen
        var transform : CGAffineTransform // sets up the transform

        // sets the transform based on the color of the previous view
        switch lastColor {
        case BLUE:
            transform = CGAffineTransformMakeTranslation(0.0, -1 * screen.height)
        case GREEN:
            transform = CGAffineTransformMakeTranslation(0.0, screen.height)
        case RED:
            transform = CGAffineTransformMakeTranslation(-1 * screen.width, 0.0)
        case ORANGE:
            transform = CGAffineTransformMakeTranslation(screen.width, 0.0)
        default:
            transform = CGAffineTransformMakeTranslation(0.0, 0.0)
        }

        var prevBackgroundView = backgroundView
        
        // creates a new view with the new color and inserts it underneath
        backgroundView = UIView(frame: CGRectMake(0, 0, screen.width, screen.height))
        backgroundView.backgroundColor = color
        mainView.insertSubview(backgroundView, belowSubview: prevBackgroundView)
        
        var arrowView = UIImageView()
        arrowView.image = arrow
        backgroundView.addSubview(arrowView)
        arrowView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // centers the arrow horizontally
        let centerX = NSLayoutConstraint(item: arrowView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: backgroundView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        backgroundView.addConstraint(centerX)
        
        // centers the arrow vertically
        let centerY = NSLayoutConstraint(item: arrowView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: backgroundView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        backgroundView.addConstraint(centerY)
        
        // sets the dimensions of the arrow to width = 185, height = 200
        let views = ["arrowView" : arrowView]
        let constrainWidth = NSLayoutConstraint.constraintsWithVisualFormat("V:[arrowView(200)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        backgroundView.addConstraints(constrainWidth)
        let constrainHeight = NSLayoutConstraint.constraintsWithVisualFormat("H:[arrowView(185)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        backgroundView.addConstraints(constrainHeight)
        
        // create the score label
        var scoreLabel = UILabel()
        scoreLabel.text = "\(score)"
        scoreLabel.textColor = UIColor.whiteColor()
        scoreLabel.font = UIFont(name: "Helvetica Bold", size: 40)
        backgroundView.addSubview(scoreLabel)
        scoreLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // position the score label using constraints
        let labelCenterX = NSLayoutConstraint(item: scoreLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: backgroundView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        backgroundView.addConstraint(labelCenterX)
        let labelBottomY = NSLayoutConstraint(item: scoreLabel, attribute: NSLayoutAttribute.TopMargin, relatedBy: NSLayoutRelation.Equal, toItem: backgroundView, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 20)
        backgroundView.addConstraint(labelBottomY)
        
        // setup the rotation for the arrow
        let pi : CGFloat = 3.14159
        var arrowRotate : CGAffineTransform
        
        switch c {
        case BLUE:
            arrowRotate = CGAffineTransformMakeRotation(0)
        case GREEN:
            arrowRotate = CGAffineTransformMakeRotation(pi)
        case RED:
            arrowRotate = CGAffineTransformMakeRotation(3*pi/2)
        case ORANGE:
            arrowRotate = CGAffineTransformMakeRotation(pi/2)
        default:
            arrowRotate = CGAffineTransformMakeRotation(0)
        }
        
        arrowView.transform = arrowRotate // rotates the arrow in the correct direction based on color
        
        // fade the arrow out based on the current difficulty
        UIView.animateWithDuration(difficulty, delay: 0.0, options: nil, animations: {arrowView.alpha = 0}, completion: nil)
        
        // creates the animation for the previous view to move away and reveal the new view
        UIView.animateWithDuration(2.0, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5.0, options: nil, animations: {prevBackgroundView.transform = transform}, completion: nil)
        
        //mainView.backgroundColor = color //sets the background color to the random color
        currentColor = c
        lastColor = c
    }
    
    func gameLost() {
        println("GAME OVER")
        self.performSegueWithIdentifier("game_over", sender: self)
    }
    
    func resetTimer() {
        
        switch score {
        case 0...5:
            difficulty = 3.0
        case 6...10:
            difficulty = 2.0
        case 11...15:
            difficulty = 1.0
        default:
            difficulty = 0.75
        }
        
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(difficulty, target: self, selector: Selector("gameLost"), userInfo: nil, repeats: false)
    }
    
    func firstChangeColor() {
        var c = Int(arc4random_uniform(4)) // picks a random number 0-3
        var color : UIColor
        
        //takes the random number and uses it to pick a color
        switch c {
        case BLUE:
            color = UIColor(red: 0.15, green: 0.32, blue: 0.7, alpha: 1.0)
        case GREEN:
            color = UIColor(red: 0, green: 0.8, blue: 0.4, alpha: 1.0)
        case RED:
            color = UIColor(red: 1.0, green: 0.16, blue: 0.24, alpha: 1.0)
        case ORANGE:
            color = UIColor(red: 1.0, green: 0.43, blue: 0.2, alpha: 1.0)
        default:
            color = UIColor.whiteColor()
        }
        
        let screen = UIScreen.mainScreen().bounds // gets the constraints of the screen

        // creates a new view with the new color
        backgroundView = UIView(frame: CGRectMake(0, 0, screen.width, screen.height))
        backgroundView.backgroundColor = color
        mainView.addSubview(backgroundView)
        
        // create the score label
        var scoreLabel = UILabel()
        scoreLabel.text = "\(score)"
        scoreLabel.textColor = UIColor.whiteColor()
        scoreLabel.font = UIFont(name: "Helvetica Bold", size: 40)
        backgroundView.addSubview(scoreLabel)
        scoreLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // position the score label using constraints
        let labelCenterX = NSLayoutConstraint(item: scoreLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: backgroundView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        backgroundView.addConstraint(labelCenterX)
        let labelBottomY = NSLayoutConstraint(item: scoreLabel, attribute: NSLayoutAttribute.TopMargin, relatedBy: NSLayoutRelation.Equal, toItem: backgroundView, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 20) // sets the distance of the score label from the top
        backgroundView.addConstraint(labelBottomY)
        
        var arrowView = UIImageView()
        arrowView.image = arrow
        backgroundView.addSubview(arrowView)
        arrowView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // centers the arrow horizontally
        let centerX = NSLayoutConstraint(item: arrowView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: backgroundView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        backgroundView.addConstraint(centerX)
        
        // centers the arrow vertically
        let centerY = NSLayoutConstraint(item: arrowView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: backgroundView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        backgroundView.addConstraint(centerY)
        
        // sets the dimmensions of the arrow to width = 185, height = 200
        let views = ["arrowView" : arrowView]
        let constrainWidth = NSLayoutConstraint.constraintsWithVisualFormat("V:[arrowView(200)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        backgroundView.addConstraints(constrainWidth)
        let constrainHeight = NSLayoutConstraint.constraintsWithVisualFormat("H:[arrowView(185)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        backgroundView.addConstraints(constrainHeight)

        // setup the rotation for the arrow
        let pi : CGFloat = 3.14159
        var arrowRotate : CGAffineTransform
        
        switch c {
        case BLUE:
            arrowRotate = CGAffineTransformMakeRotation(0)
        case GREEN:
            arrowRotate = CGAffineTransformMakeRotation(pi)
        case RED:
            arrowRotate = CGAffineTransformMakeRotation(3*pi/2)
        case ORANGE:
            arrowRotate = CGAffineTransformMakeRotation(pi/2)
        default:
            arrowRotate = CGAffineTransformMakeRotation(0)
        }
        
        arrowView.transform = arrowRotate // rotates the arrow in the correct direction based on color

        currentColor = c
        lastColor = c
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var nextView: GameOverViewController = segue.destinationViewController as! GameOverViewController
        nextView.score = self.score
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }


}

