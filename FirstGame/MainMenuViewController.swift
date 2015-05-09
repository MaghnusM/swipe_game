//
//  MainMenuViewController.swift
//  FirstGame
//
//  Created by Felix Parker on 3/19/15.
//  Copyright (c) 2015 Felix Parker. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet var MainMenuView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var instructionsButton: UIButton!
    
    let play_green = UIImage(named: "play_green") as UIImage?
    let play_blue = UIImage(named: "play_blue") as UIImage?
    let play_red = UIImage(named: "play_red") as UIImage?
    let play_orange = UIImage(named: "play_orange") as UIImage?
    
    let instructions_green = UIImage(named: "instructions_green") as UIImage?
    let instructions_blue = UIImage(named: "instructions_blue") as UIImage?
    let instructions_red = UIImage(named: "instructions_red") as UIImage?
    let instructions_orange = UIImage(named: "instructions_orange") as UIImage?
    
    var timer = NSTimer()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeBackground()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("changeBackground"), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeBackground() {
        if count < 4 {
            count++
        } else {
            count = 1
        }
        
        switch count {
        case 1:
            MainMenuView.backgroundColor = UIColor(red: 0, green: 0.8, blue: 0.4, alpha: 1.0)
            playButton.setImage(play_green, forState: .Normal)
            //instructionsButton.setImage(instructions_green, forState: .Normal)
        case 2:
            MainMenuView.backgroundColor = UIColor(red: 1.0, green: 0.16, blue: 0.24, alpha: 1.0)
            playButton.setImage(play_red, forState: .Normal)
            //instructionsButton.setImage(instructions_red, forState: .Normal)
        case 3:
            MainMenuView.backgroundColor = UIColor(red: 1.0, green: 0.43, blue: 0.2, alpha: 1.0)
            playButton.setImage(play_orange, forState: .Normal)
            //instructionsButton.setImage(instructions_orange, forState: .Normal)
        case 4:
            MainMenuView.backgroundColor = UIColor(red: 0.15, green: 0.32, blue: 0.7, alpha: 1.0)
            playButton.setImage(play_blue, forState: .Normal)
            //instructionsButton.setImage(instructions_blue, forState: .Normal)
        default:
            MainMenuView.backgroundColor = UIColor.whiteColor()
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
