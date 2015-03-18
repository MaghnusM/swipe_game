//
//  FileManager.swift
//  FirstGame
//
//  Created by Felix Parker on 3/17/15.
//  Copyright (c) 2015 Felix Parker. All rights reserved.
//

import Foundation

class FileManager {
    
    let fileName = "highscore.txt"
    let path : String
    
    init() {
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let dir = dirPaths[0] as String
        
        path = dir + "/" + fileName
        //println(path)
    }
    
    func writeScore(score:Int) {
        let s = String(score)
        s.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding, error: nil);
    }
    
    func readScore() -> Int {
        let s = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!
        return s.toInt()!
    }
    
}