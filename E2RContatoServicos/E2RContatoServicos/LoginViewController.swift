//
//  LoginViewController.swift
//  E2RContatoServicos
//
//  Created by Rodrigo A E Miyashiro on 7/6/15.
//  Copyright (c) 2015 Rodrigo A E Miyashiro. All rights reserved.
//

import UIKit
import Parse





class LoginViewController: UIViewController {
    
    // MARK:-Properties

    @IBOutlet weak var userLoginTextBox: UITextField!
    @IBOutlet weak var userLoginPassword: UITextField!
    var result: Bool!
    
    //#MARK:-View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.backBarButtonItem?.title = "Voltar"
    }
    
    override func viewWillAppear(animated: Bool){
        self.navigationItem.backBarButtonItem?.title = "Voltar"
        
    }
    
    
    // MARK: - Login methods
    
    
    
    /**
    Perform the login of a user in web service.
    - returns: void
    */
    func login(){
        
//        var user = PFUser()
        let query = PFUser.query()
        query?.whereKey("username", equalTo: self.userLoginTextBox.text!)
        let users = query?.findObjects()
        var isServiceProvider : Int!
        
        PFUser.logInWithUsernameInBackground(userLoginTextBox.text!, password: userLoginPassword.text!) { (user:PFUser?, error:NSError?) -> Void in
            if user != nil {
                for user in users as! [PFUser] {
                    isServiceProvider = user["isServiceProvider"] as! Int
                }
                
                if(isServiceProvider! == 0){
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let mainVC = storyboard.instantiateViewControllerWithIdentifier("listServiceProvider") as! ListServiceProviderCollectionViewController
                        
//                        self.presentViewController(mainVC, animated: true, completion: nil)
                        self.navigationController?.pushViewController(mainVC, animated: true)
                        
                    })
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let perfilVC = storyboard.instantiateViewControllerWithIdentifier("perfilVC") as! ProvidersTableViewController
                        perfilVC.providerServiceUser = user!
                        
                        self.navigationController?.pushViewController(perfilVC, animated: true)
                    })

                    
                }
               
                
            }else {
                let alertController = UIAlertController(title: NSLocalizedString("ERRO", comment: "Title of the alert error"), message: NSLocalizedString("Usuário ou senha incorretos",  comment: "default message of login error"), preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: NSLocalizedString("OK",  comment: "confimation message"), style: .Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
        }
 
        
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.userLoginTextBox.resignFirstResponder()
        self.userLoginPassword.resignFirstResponder()
    }
    
    
   
    @IBAction func loginAction(sender: UIButton) {
        self.login()
        
    }
    
    

   

}
