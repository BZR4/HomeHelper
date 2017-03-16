//
//  ChallengeDAO.swift
//  MiniChallengeTracker
//
//  Created by Fernando Celarino on 6/23/15.
//  Copyright (c) 2015 Fernando Celarino. All rights reserved.
//

import Foundation
import CoreData

class ChallengeDAO
{
    static func findByNameAndDuration(name: String, duration: NSInteger) -> [Challenge]
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Challenge")
        
        // assign predicate
        request.predicate = NSPredicate(format: "name == %@ AND duration >= %ld", name, duration)
        
        // assign sort descriptor
        request.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending:true)]
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Challenge] = (try! DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request)) as! [Challenge]
        
        return results
    }
    
    static func findByName(name: String) -> Challenge?
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Challenge")
        
        // assign predicate
        request.predicate = NSPredicate(format: "name == %@", name)
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Challenge] = (try! DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request)) as! [Challenge]
        
        return results[0]
    }

    
    static func insert(objectToBeInserted:Challenge)
    {
        // insert element into context
        DatabaseManager.sharedInstance.managedObjectContext?.insertObject(objectToBeInserted)
        
        // save context
        let error:NSErrorPointer = nil
        do {
            try DatabaseManager.sharedInstance.managedObjectContext?.save()
        } catch let error1 as NSError {
            error.memory = error1
        }
        if (error != nil)
        {
            // log error
            print(error, terminator: "")
        }
    }

    static func delete(objectToBeDeleted:Challenge)
    {
        // remove object from context
        let error:NSErrorPointer = nil
        DatabaseManager.sharedInstance.managedObjectContext?.deleteObject(objectToBeDeleted)
        do {
            try DatabaseManager.sharedInstance.managedObjectContext?.save()
        } catch let error1 as NSError {
            error.memory = error1
        }
        
        // log error
        if (error != nil)
        {
            // log error
            print(error, terminator: "")
        }
    }

}