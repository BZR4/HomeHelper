//
//  MakeCall.swift
//  E2RContatoServicos
//
//  Created by Rodrigo A E Miyashiro on 7/8/15.
//  Copyright (c) 2015 Rodrigo A E Miyashiro. All rights reserved.
//

import UIKit

class MakeCall: NSObject {
   
    static func makeCall (phoneNumber: String) {
        let url:NSURL = NSURL(string: "tel://\(phoneNumber)")!
        UIApplication.sharedApplication().openURL(url)
    }
}
