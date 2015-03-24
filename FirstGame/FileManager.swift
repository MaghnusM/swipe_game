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
        s.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
    }
    
    func readScore() -> Int {
        checkFile() //ensures that the file exists
        
        var s = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)! // reads the contents of the file

        s = s.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) //removes any whitespace characters that prevent converting the string to an int

        return s.toInt()! //converts the string to an int and returns it
    }
    
    func checkFile() {
        let manager = NSFileManager.defaultManager()
        //println(path)
        
        if (!manager.fileExistsAtPath(path)) {
            let s = "0"
            s.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
        }
    }
    
}