//
//  ValidatePhoneNumber.swift
//  E2RContatoServicos
//
//  Created by Rodrigo A E Miyashiro on 7/8/15.
//  Copyright (c) 2015 Rodrigo A E Miyashiro. All rights reserved.
//

import UIKit

class ValidatePhoneNumber: NSObject {
   
    // 11 9812 1234 ou 11 99128 1234
    static func isPhoneNumber(candidate: String) -> Bool {
        let phoneNumberRegex = "^[0-9]{2}([0-9]{4}|[0-9]{5})[0-9]{4}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex).evaluateWithObject(candidate)
    }
}
