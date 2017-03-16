//
//  RatingViewController.swift
//  E2RContatoServicos
//
//  Created by Esdras Bezerra da Silva on 16/07/15.
//  Copyright (c) 2015 Rodrigo A E Miyashiro. All rights reserved.
//

import UIKit
import Parse

class RatingViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var blackView: UIView!
    
    @IBOutlet weak var dialogView:UIView!
    
    @IBOutlet weak var containerView: UIView!
    
    var provider: PFUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scale = CGAffineTransformMakeScale(0.0, 0.0)
        let translate = CGAffineTransformMakeTranslation(0, 500)
        dialogView.transform = CGAffineTransformConcat(scale, translate)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.6,
        initialSpringVelocity: 0.5, options: [], animations: {
        let scale = CGAffineTransformMakeScale(1, 1)
        let translate = CGAffineTransformMakeTranslation(0, 0)
        self.dialogView.transform = CGAffineTransformConcat(scale, translate)
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnRating(sender: AnyObject) {
        switch sender.tag {
        case 0:
            print("Bad")
            print("Teste")
            self.registerEvaluation(provider, nameOfEvaluation: "eBad")
        case 1:
            print("Good")
            self.registerEvaluation(provider, nameOfEvaluation: "eRegular")
        case 2:
            print("Great")
            self.registerEvaluation(provider, nameOfEvaluation: "eGood")
        default:
            print("Shit happens")
        }
        
        animationRatingSelected(sender)
    }
    
 
    
    func animationRatingSelected (sender: AnyObject) {
        
        let button = sender.viewWithTag(sender.tag) as! UIButton
        
        UIView.animateWithDuration(0.6, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: { () -> Void in
            
            let scale1 = CGAffineTransformMakeScale(1.5, 1.5)
            button.transform = scale1
            
            
        }) { (results) -> Void in
            
            UIView.animateWithDuration(0.6, animations: { () -> Void in
                
                let scale2 = CGAffineTransformMakeScale(0.5, 0.5)
                button.transform = scale2
                
            })
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
    }
    
    func registerEvaluation(user:PFUser, nameOfEvaluation:String){
        
        let eval = PFObject(className: "Evaluation")
        
        eval [nameOfEvaluation] = 1
        eval ["idObject"] = provider.objectId
        
        eval.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if success {
                let alert = UIAlertView(title:NSLocalizedString("Avaliado", comment: "dafault message after the evaluation") , message: NSLocalizedString("Prestador de serviço avaliado", comment: "message that apear after the evaluation"), delegate: self, cancelButtonTitle: NSLocalizedString("OK", comment: "default message for the button"))
                alert.show()
                
            }else{
                let alert = UIAlertView(title:NSLocalizedString("Falha", comment: "dafault message after a failure in the evaluation") , message: NSLocalizedString("falha na avaliação do prestador de serviço", comment: "message that apear after failure in the evaluation"), delegate: self, cancelButtonTitle: NSLocalizedString("OK", comment: "default message for the button"))
                alert.show()
                
            }
        }
    }
    
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
