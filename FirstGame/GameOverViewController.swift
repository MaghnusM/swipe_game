//
//  GameOverViewController.swift
//  FirstGame
//
//  Created by Felix Parker on 3/17/15.
//  Copyright (c) 2015 Felix Parker. All rights reserved.
//


import UIKit

class GameOverViewController: UIViewController {
    
    var score : Int!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    let fileManager = FileManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (score > fileManager.readScore()) {
            fileManager.writeScore(score)
        }
        
        let highscore = fileManager.readScore()
        scoreLabel.text = "Score: \(score)"
        highscoreLabel.text = "High Score: \(highscore)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
