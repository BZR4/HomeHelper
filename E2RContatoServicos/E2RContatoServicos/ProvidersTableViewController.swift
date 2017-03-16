//
//  ProvidersTableViewController.swift
//  E2RContatoServicos
//
//  Created by Esdras Bezerra da Silva on 16/07/15.
//  Copyright (c) 2015 Rodrigo A E Miyashiro. All rights reserved.
//

import UIKit
import Parse

class ProvidersTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var providerServiceUser: PFUser?
    
    var isEdit: Bool = false
    

    let titleBtnEdit = NSLocalizedString("Editar", comment: "Value for the button in an edit state for the view")
    let titleBtnSave = NSLocalizedString("Salvar",comment: "title for the button present in the view")
    
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var btnSaveEdit: UIBarButtonItem!

    @IBOutlet var myTableView: UITableView!
    
    // MARK: - Color used
    
    let green = UIColor(red: 34.0/255.0, green: 160/255, blue: 43.0/255.0, alpha: 1.0)
    let gray = UIColor.lightGrayColor()
    
    
    // MARK: - code from view Controller 
    
    
    //MARK: - properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPhoneTextField: UITextField!
    @IBOutlet weak var userCityTextField: UITextField!
    @IBOutlet weak var userNeighborhoodTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    // Button's
    @IBOutlet weak var btnWash: UIButton!
    @IBOutlet weak var btnIroning: UIButton!
    @IBOutlet weak var btnCook: UIButton!
    @IBOutlet weak var btnClean: UIButton!
    @IBOutlet weak var btnOthers: UIButton!
    
    @IBOutlet weak var btnMonday: UIButton!
    @IBOutlet weak var btnTuesday: UIButton!
    @IBOutlet weak var btnWednesday: UIButton!
    @IBOutlet weak var btnThursday: UIButton!
    @IBOutlet weak var btnFriday: UIButton!
    @IBOutlet weak var btnSaturday: UIButton!
    @IBOutlet weak var btnSunday: UIButton!
    
    @IBOutlet weak var btnMorning: UIButton!
    @IBOutlet weak var btnAfternoon: UIButton!
    @IBOutlet weak var btnIntegral: UIButton!
    @IBOutlet weak var btnLogout: UIBarButtonItem!
    
    
    var hasWash:Bool = false
    var hasIroning:Bool = false
    var hasCook:Bool = false
    var hasClean:Bool = false
    var hasOthers:Bool = false
    
    var hasMonday:Bool = false
    var hasTuesday:Bool = false
    var hasWednesday:Bool = false
    var hasThursday:Bool = false
    var hasFriday:Bool = false
    var hasSanturday:Bool = false
    var hasSunday:Bool = false
    
    var hasMorning:Bool = false
    var hasAfternoon:Bool = false
    var hasIntegral:Bool = false
    
    var userID: String!
    var user = PFUser()
    
    var stateAfternoon = false
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "setupImageUpload")
        
        self.imageProfile!.addGestureRecognizer(tapGesture)
        
        self.btnLogout.title = (NSLocalizedString("Sair", comment: "the message present in logout button"))
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var title: String?
        
        if let currentUser = self.providerServiceUser {//!.objectId {
            title = self.titleBtnEdit
            self.loadingProvidorService(currentUser)
            self.isEdit = true
            
        }else {
            title = self.titleBtnSave
            self.isEdit = false
        }
        
        enableComponets(!self.isEdit)
        self.btnSaveEdit.title = title;
    }
    
    
    // MARK: - enable componets
    
    func enableComponets(isEnable:Bool) {
        self.userNameTextField.enabled = isEnable
        self.fullNameTextField.enabled = isEnable
        self.userPasswordTextField.enabled = isEnable
        self.userEmailTextField.enabled = isEnable
        self.userPhoneTextField.enabled = isEnable
        self.userCityTextField.enabled = isEnable
        self.userNeighborhoodTextField.enabled = isEnable
        self.fullNameTextField.enabled = isEnable
        self.descriptionTextField.enabled = isEnable
        
        
        // Button's
        self.btnWash.enabled = isEnable
        self.btnIroning.enabled = isEnable
        self.btnCook.enabled = isEnable
        self.btnClean.enabled = isEnable
        self.btnOthers.enabled = isEnable
        
        self.btnMonday.enabled = isEnable
        self.btnTuesday.enabled = isEnable
        self.btnWednesday.enabled = isEnable
        self.btnThursday.enabled = isEnable
        self.btnFriday.enabled = isEnable
        self.btnSaturday.enabled = isEnable
        self.btnSunday.enabled = isEnable
        
        self.btnMorning.enabled = isEnable
        self.btnAfternoon.enabled = isEnable
        self.btnIntegral.enabled = isEnable
    }
    
    
    // MARK: - Loading info providor service
    
    func loadingProvidorService(user: PFUser) {
        
        self.fullNameTextField.text = user["fullName"] as? String
        self.userNameTextField.text = user["username"] as? String
        
        self.userPasswordTextField.placeholder = "**********"
        
        self.userEmailTextField.text = user["email"] as? String
        self.userPhoneTextField.text = user["contact"] as? String
        self.userCityTextField.text = user["city"] as? String
        self.descriptionTextField.text = user["selfDescription"] as? String
        
        
        // Button's
        self.btnWash.tintColor      = user["doTheLaundry"]      as! Bool ? green : gray
        self.btnIroning.tintColor   = user["ironTheClochtes"]   as! Bool ? green : gray
        self.btnCook.tintColor      = user["cook"]              as! Bool ? green : gray
        self.btnClean.tintColor     = user["cleanTheHouse"]     as! Bool ? green : gray
        self.btnOthers.tintColor    = user["otherServices"]     as! Bool ? green : gray
        
        self.btnMonday.tintColor    = user["monday"]            as! Bool ? green : gray
        self.btnTuesday.tintColor   = user["tuesday"]           as! Bool ? green : gray
        self.btnWednesday.tintColor = user["wednesday"]         as! Bool ? green : gray
        self.btnThursday.tintColor  = user["thursday"]          as! Bool ? green : gray
        self.btnFriday.tintColor    = user["friday"]            as! Bool ? green : gray
        self.btnSaturday.tintColor  = user["saturday"]          as! Bool ? green : gray
        self.btnSunday.tintColor    = user["sunday"]            as! Bool ? green : gray
        
        self.btnMorning.tintColor   = user["morning"]           as! Bool ? green : gray
        self.btnAfternoon.tintColor = user["afternoon"]         as! Bool ? green : gray
        self.btnIntegral.tintColor  = user["integral"]          as! Bool ? green : gray
    }
    
    
    // MARK: - Image Picker
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.imageProfile.image = image
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: - Upload image
    
    func setupImageUpload(){
        print("Click")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    // MARK: - Check List
    @IBAction func isWash(sender: AnyObject) {
        if self.hasWash == false {
            self.hasWash = true
            self.btnWash.tintColor = green
        } else{
            self.hasWash = false
            self.btnWash.tintColor = gray
        }
    }
    
    @IBAction func isIroning(sender: AnyObject) {
        if self.hasIroning == false {
            self.hasIroning = true
            self.btnIroning.tintColor = green
        } else{
            self.hasIroning = false
            self.btnIroning.tintColor = gray
        }
    }
    
    @IBAction func isCook(sender: AnyObject) {
        if self.hasCook == false {
            self.hasCook = true
            self.btnCook.tintColor = green
        } else{
            self.hasCook = false
            self.btnCook.tintColor = gray
        }
    }
    
    @IBAction func isClean(sender: AnyObject) {
        if self.hasClean == false {
            self.hasClean = true
            self.btnClean.tintColor = green
        } else{
            self.hasClean = false
            self.btnClean.tintColor = gray
        }
    }
    
    @IBAction func isOthers(sender: AnyObject) {
        if self.hasOthers == false {
            self.hasOthers = true
            self.btnOthers.tintColor = green
        } else{
            self.hasOthers = false
            self.btnOthers.tintColor = gray
        }
    }
    
    
    
    @IBAction func isMonday(sender: AnyObject) {
        if self.hasMonday == false {
            self.hasMonday = true
            self.btnMonday.tintColor = green
        } else{
            self.hasMonday = false
            self.btnMonday.tintColor = gray
        }
    }
    
    @IBAction func isTuesday(sender: AnyObject) {
        if self.hasTuesday == false {
            self.hasTuesday = true
            self.btnTuesday.tintColor = green
        } else{
            self.hasTuesday = false
            self.btnTuesday.tintColor = gray
        }
    }
    
    @IBAction func isWednesday(sender: AnyObject) {
        if self.hasWednesday == false {
            self.hasWednesday = true
            self.btnWednesday.tintColor = green
        } else{
            self.hasWednesday = false
            self.btnWednesday.tintColor = gray
        }
    }
    
    @IBAction func isThursday(sender: AnyObject) {
        if self.hasThursday == false {
            self.hasThursday = true
            self.btnThursday.tintColor = green
        } else{
            self.hasThursday = false
            self.btnThursday.tintColor = gray
        }
    }
    
    @IBAction func isFriday(sender: AnyObject) {
        if self.hasFriday == false {
            self.hasFriday = true
            self.btnFriday.tintColor = green
        } else{
            self.hasFriday = false
            self.btnFriday.tintColor = gray
        }
    }
    
    @IBAction func isSaturday(sender: AnyObject) {
        if self.hasSanturday == false {
            self.hasSanturday = true
            self.btnSaturday.tintColor = green
        } else{
            self.hasSanturday = false
            self.btnSaturday.tintColor = gray
        }
    }
    
    @IBAction func isSunday(sender: AnyObject) {
        if self.hasSunday == false {
            self.hasSunday = true
            self.btnSunday.tintColor = green
        } else{
            self.hasSunday = false
            self.btnSunday.tintColor = gray
        }
    }
    
    
    @IBAction func isMorning(sender: AnyObject) {
        if self.hasMorning == false {
            self.btnMorning.setImage(UIImage(named: "Sunrise Filled-100"), forState: .Normal)
            self.hasMorning = true
            self.btnMorning.tintColor = green
        } else{
            self.btnMorning.setImage(UIImage(named: "Sunrise-100"), forState: .Normal)
            self.hasMorning = false
            self.btnMorning.tintColor = gray
        }
    }
    
    @IBAction func isAfternoon(sender: AnyObject) {
        if self.hasAfternoon == false {
            self.btnAfternoon.setImage(UIImage(named: "Sunset Filled-100"), forState: .Normal)
            self.hasAfternoon = true
            self.btnAfternoon.tintColor = green
        } else{
            self.btnAfternoon.setImage(UIImage(named: "Sunset-100"), forState: .Normal)
            self.hasAfternoon = false
            self.btnAfternoon.tintColor = gray
        }
        
//        changeStatusButton(self.btnAfternoon, status: self.hasAfternoon)
        
    }
    
    @IBAction func isIntegral(sender: AnyObject) {
        if self.hasIntegral == false {
            self.hasIntegral = true
            self.btnIntegral.tintColor = green
        } else{
            self.hasIntegral = false
            self.btnIntegral.tintColor = gray
        }
    }
    
    
  
    
    func getScrollViewHeight()->CGFloat{
        var scrollViewHeight:CGFloat = 0.0
        
        for view in scrollView.subviews{
            scrollViewHeight += view.frame.size.height
        }
        return scrollViewHeight
    }
    
    // MARK: - Register methods
    func registerNewUser(){
        
        user.username = userNameTextField.text
        user.password = userPasswordTextField.text
        user["contact"] = userPhoneTextField.text
        user.email = userEmailTextField.text
        user["fullName"] = fullNameTextField.text
        user["city"] = userCityTextField.text!.uppercaseString
        user["selfDescription"] = descriptionTextField.text
        user["ironTheClochtes"] = hasIroning
        user["doTheLaundry"] = hasWash
        user["cook"] = hasCook
        user["cleanTheHouse"] = hasClean
        user["otherServices"] = hasOthers
        user["monday"] = hasMonday
        user["tuesday"] = hasTuesday
        user["wednesday"] = hasWednesday
        user["thursday"] = hasThursday
        user["friday"] = hasFriday
        user["saturday"] = hasSanturday
        user["sunday"] = hasSunday
        user["morning"] = hasMorning
        user["afternoon"] = hasAfternoon
        user["integral"] = hasIntegral
        user["isServiceProvider"] = true
        
        let imageData = UIImagePNGRepresentation(self.imageProfile.image!)
        let parseImageFile = PFFile(name: "imageProfile", data: imageData!)
        
        user["imageProfile"] = parseImageFile
        
        user.signUpInBackgroundWithBlock { (success:Bool, error : NSError?) -> Void in
            if(success){
                
                self.enableComponets(false)
                
                print("new service provider registered")
                let alertSuccess = UIAlertController(title: NSLocalizedString("Salvo", comment: "message that alert the user that the register was successful"), message: "usuário cadastrado", preferredStyle: UIAlertControllerStyle.Alert)
                alertSuccess.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "default message for confirmation"), style: UIAlertActionStyle.Default, handler: nil))
                
                
                

                
                self.presentViewController(alertSuccess, animated: true, completion: nil)
                
            }else{
                print("erro")
                let alertFailure = UIAlertController(title: NSLocalizedString("falha", comment: "message that alert the user that the register was failure"), message: "Falha no registro", preferredStyle: UIAlertControllerStyle.Alert)
                alertFailure.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "default message for confirmation"), style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alertFailure, animated: true, completion: nil)
                
                self.isEdit = false
                self.btnSaveEdit.title = self.titleBtnSave
            }
        }
        
        
        
        
    }

    
    func editPerfil(user:PFUser){

        if let name = userNameTextField.text{
            user["username"] = name
        }
        if let description = userNeighborhoodTextField.text{
            user["selfDescription"] = description
        }
        if let phone = userPhoneTextField.text{
            user["contact"] = phone
        }
        if let password = userPasswordTextField.text{
            user["password"] = password
        }
        
        if let email = userEmailTextField.text {
            user.email = email
        }
    
        user["ironTheClochtes"] = btnIroning.tintColor   == green ? true : false
        user["doTheLaundry"]    = btnWash.tintColor      == green ? true : false
        user["cook"]            = btnCook.tintColor      == green ? true : false
        user["cleanTheHouse"]   = btnClean.tintColor     == green ? true : false
        user["otherServices"]   = btnOthers.tintColor    == green ? true : false
        user["monday"]          = btnMonday.tintColor    == green ? true : false
        user["tuesday"]         = btnTuesday.tintColor   == green ? true : false
        user["wednesday"]       = btnWednesday.tintColor == green ? true : false
        user["thursday"]        = btnThursday.tintColor  == green ? true : false
        user["friday"]          = btnFriday.tintColor    == green ? true : false
        user["saturday"]        = btnSaturday.tintColor  == green ? true : false
        user["sunday"]          = btnSunday.tintColor    == green ? true : false
        user["morning"]         = btnMorning.tintColor   == green ? true : false
        user["afternoon"]       = btnAfternoon.tintColor == green ? true : false
        user["integral"]        = btnIntegral.tintColor  == green ? true : false
        
        
        PFUser.currentUser()?.saveInBackgroundWithBlock({ (success:Bool, error: NSError?) -> Void in
            if success{
                let alertSuccess = UIAlertController(title: NSLocalizedString("Salvo", comment: "message that alert the user that the update was successful"), message: "Informações alteradas", preferredStyle: UIAlertControllerStyle.Alert)
                alertSuccess.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "default message for confirmation"), style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alertSuccess, animated: true, completion: nil)
                
            }else{
                let alertFailure = UIAlertController(title: NSLocalizedString("falha", comment: "message that alert the user that the update was failure"), message: "Falha no upadate", preferredStyle: UIAlertControllerStyle.Alert)
                alertFailure.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "default message for confirmation"), style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alertFailure, animated: true, completion: nil)
            }
            
        })
      
    }
    
    
    // 
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

    // MARK: - Save or Edit profile provider service
    @IBAction func btnINBSaveEdit(sender: AnyObject) {

        if self.isEdit {
            self.isEdit = false
            self.btnSaveEdit.title = self.titleBtnSave            
        }
        else {
            
            if let user = self.providerServiceUser {
                self.editPerfil(user)
                self.isEdit = true
            }else{
                self.registerNewUser()
            }
            
            self.btnSaveEdit.title = self.titleBtnEdit
        }
        enableComponets(!self.isEdit)
    }

    @IBAction func logout(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func textFieldShouldReturn(textField:UITextField)->Bool{
       textField.resignFirstResponder()
        return true
    }
}
