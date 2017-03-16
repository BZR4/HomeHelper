//
//  ManagedObjectModelClass.swift
//  MiniChallengeTracker
//
//  Created by Rodrigo A E Miyashiro on 6/29/15.
//  Copyright (c) 2015 Fernando Celarino. All rights reserved.
//

import Foundation
import CoreData

class ManagedObjectModelClass {
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("E2RContatoServicos", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
}