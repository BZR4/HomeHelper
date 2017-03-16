//
//  CadastroUsuarioSimplesViewController.swift
//  E2RContatoServicos
//
//  Created by Rodrigo A E Miyashiro on 7/6/15.
//  Copyright (c) 2015 Rodrigo A E Miyashiro. All rights reserved.
//

import UIKit
import Parse

class UserRegistrationViewController: UIViewController {
    
    // MARK:-Properties
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    var user = PFUser()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Register methods
    
    

    /**
    used to register a new ordinary user in the database
    
    - parameter void:
    
    - returns: a new user registered in the web database.
    */
    func registerNewUser(){
        
        user.username = userNameTextField.text
        user.password = userPasswordTextField.text
        user["contact"] = NSNull()
        user.email = userEmailTextField.text
        user["city"] = NSNull()
        user["ironTheClochtes"] = false
        user["doTheLaundry"] = false
        user["cook"] = false
        user["cleanTheHouse"] = false
        user["otherServices"] = false
        user["monday"] = false
        user["tuesday"] = false
        user["wednesday"] = false
        user["thursday"] = false
        user["friday"] = false
        user["saturday"] = false
        user["sunday"] = false
        user["morning"] = false
        user["afternoon"] = false
        user["integral"] = false
        user["isServiceProvider"] = false
        
        user.signUpInBackgroundWithBlock { (success:Bool, error : NSError?) -> Void in
            if(success){
                print("new service provider registered")
                let alertSuccess = UIAlertController(title: NSLocalizedString("Salvo", comment: "message that alert the user that the register was successful"), message: "usuário cadastrado", preferredStyle: UIAlertControllerStyle.Alert)
                alertSuccess.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "default message for confirmation"), style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alertSuccess, animated: true, completion: nil)
            }else{
                print("erro")
                
                let alertFailure = UIAlertController(title: NSLocalizedString("falha", comment: "message that alert the user that the register was failure"), message: "Falha no registro", preferredStyle: UIAlertControllerStyle.Alert)
                alertFailure.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "default message for confirmation"), style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alertFailure, animated: true, completion: nil)

            }
        }
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.userEmailTextField.resignFirstResponder()
        self.userNameTextField.resignFirstResponder()
        self.userPasswordTextField.resignFirstResponder()
    }
    @IBAction func saveNewRegister(sender: UIButton) {
        self.registerNewUser()        
    }


}
