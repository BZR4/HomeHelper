//
//  MiddleSegue.swift
//  TestCustomSegue
//
//  Created by Rodrigo A E Miyashiro on 7/14/15.
//  Copyright (c) 2015 Rodrigo A E Miyashiro. All rights reserved.
//

import UIKit

class MiddleSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let sourceViewController:UIViewController = self.sourceViewController 
        let destinationViewController: UIViewController = self.destinationViewController 
        
        sourceViewController.view.addSubview(destinationViewController.view)
        
        destinationViewController.view.alpha = 0.1
        destinationViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05)        
        
        UIView.animateWithDuration(0.7, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            destinationViewController.view.alpha = 1.0
            destinationViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
            
        }) { (finished) -> Void in
            
            destinationViewController.view.removeFromSuperview()
            sourceViewController.presentViewController(destinationViewController, animated: false, completion: nil)
            
        }
    }
   
}
