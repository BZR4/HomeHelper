//
//  ValidateEmail.swift
//  E2RContatoServicos
//
//  Created by Rodrigo A E Miyashiro on 7/8/15.
//  Copyright (c) 2015 Rodrigo A E Miyashiro. All rights reserved.
//

import UIKit

class ValidateEmail: NSObject {
   
    static func isEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(candidate)
    }

    
}
