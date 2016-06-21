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
    func saveHighscore() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("HighScore", inManagedObjectContext:managedContext)
        
        let highScore = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        print(highScore) //TODO: Tirar esse print
        
        // TO-DO : Pegar o tempo e salvar
//        highScore.setValue(self.time, forKey: "highscore")
        
        do {
            try managedContext.save()
            
        }catch{
            fatalError("failure to save highsore: \(error)")
        }
    }
    
    func getSavedHIghScore() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "HighScore")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            
            print(results)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    

}
