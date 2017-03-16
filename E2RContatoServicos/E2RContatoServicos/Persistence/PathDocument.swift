//
//  PathDocument.swift
//  MiniChallengeTracker
//
//  Created by Rodrigo A E Miyashiro on 6/29/15.
//  Copyright (c) 2015 Fernando Celarino. All rights reserved.
//

import Foundation

class PathDocument {
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "br.com.fcel.MiniChallengeTracker" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] 
        }()
}