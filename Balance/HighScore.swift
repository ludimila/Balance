//
//  HighScore.swift
//  Balance
//
//  Created by Euler Tiago Rodrigues de Carvalho on 5/12/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import CoreData


class HighScore: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    class func saveHighscore(score: Double) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("HighScore", inManagedObjectContext:managedContext)
        
        let highScore = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! HighScore
        
        highScore.highscore = score
        
        do {
            try managedContext.save()
            
        }catch{
            fatalError("failure to save highsore: \(error)")
        }

       self.getSavedHIghScore()
    }
    
    class func getSavedHIghScore()  {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var results = [AnyObject]()
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "HighScore")
        
        do {
             results = try managedContext.executeFetchRequest(fetchRequest)
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        let dictionary = results.last!
        
        
        
    }
}
