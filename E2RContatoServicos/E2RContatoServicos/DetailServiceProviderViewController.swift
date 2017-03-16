//
//  DetalhePrestadorServiçosViewController.swift
//  E2RContatoServicos
//
//  Created by Rodrigo A E Miyashiro on 7/6/15.
//  Copyright (c) 2015 Rodrigo A E Miyashiro. All rights reserved.
//

import UIKit
import Parse

class DetailServiceProviderViewController: UIViewController {
    
    @IBOutlet weak var providerImageView: UIImageView!
    
    var provider = PFUser()// = PFUser()
    var test:String?

    @IBOutlet weak var btnMonday: UIButton!
    @IBOutlet weak var btnTuesday: UIButton!
    @IBOutlet weak var btnWedneday: UIButton!
    @IBOutlet weak var btnThuesday: UIButton!
    @IBOutlet weak var btnFriday: UIButton!
    @IBOutlet weak var btnSaturday: UIButton!
    @IBOutlet weak var btnSunday: UIButton!
    @IBOutlet weak var morningImageView: UIImageView!
    @IBOutlet weak var eveningImageView: UIImageView!
    @IBOutlet weak var fullDayImageView: UIImageView!
    @IBOutlet weak var homeCleaningImageView: UIImageView!
    @IBOutlet weak var whasingMachineImageView: UIImageView!
    @IBOutlet weak var ironImageView: UIImageView!
    @IBOutlet weak var kitchenImageView: UIImageView!
    @IBOutlet weak var moreImageView: UIImageView!
    
    @IBOutlet weak var selfDescriptionTextView: UITextView!
 
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var btnDismiss: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnDismiss.tintColor = UIColor(red: 34.0/255.0, green: 160/255, blue: 43.0/255.0, alpha: 1.0)

        // Do any additional setup after loading the view.
        updateData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Saida: \(test)")
        
        providerImageView.layer.cornerRadius = providerImageView.frame.width / 2
    }
    
    @IBAction func close(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func makeCallForProvider(sender: AnyObject) {
        if let phone = self.provider.objectForKey("contact") as? String {
            if ValidatePhoneNumber.isPhoneNumber(phone){
                MakeCall.makeCall(phone)
            }else{
                print("Fail")
                //let alert = UIAlertView(title: "Alerta", message: "Número cadastrado em formato inválido", delegate: self, cancelButtonTitle: "Ok")
                let alert = UIAlertView(title: NSLocalizedString("Alerta",  comment: "Title of alert message"), message: NSLocalizedString("Número cadastrado em formato inválido",  comment: "content of message that alert the user that the format of number is invalid"), delegate: self, cancelButtonTitle: NSLocalizedString("OK", comment: "message for the confirmation button"))
                alert.show()
            }
        }else{
            //let alert = UIAlertView(title: "Ops!", message: "A prestadora não cadastrou um teelefone!\nQue pena, perdeu a oportunidade de prestar serviço para você!", delegate: self, cancelButtonTitle: "Ok")
            let alert = UIAlertView(title: NSLocalizedString("Ops!", comment: "alert message for a failure"), message: NSLocalizedString("A prestadora não cadastrou um teelefone!\nQue pena, perdeu a oportunidade de prestar serviço para você!", comment: "alert message saying that the service provider doesn't have a phone number registered"), delegate: self, cancelButtonTitle: NSLocalizedString("Ok",  comment: "message for the confirmation button"))
            alert.show()
        }
    }
    
    func updateData(){
        print("ID: \(self.provider.objectId)")
        
        let defaultColor = UIColor(red: 34.0/255.0, green: 160/255, blue: 43.0/255.0, alpha: 1.0)
        
        if ((self.provider.objectForKey("monday") as! Int) == 1){
            self.btnMonday.setBackgroundImage(UIImage(named: "Monday Filled-100"), forState: .Normal)
            self.btnMonday.tintColor = defaultColor
        }
        if ((self.provider.objectForKey("tuesday") as! Int) == 1){
            self.btnTuesday.setBackgroundImage(UIImage(named: "Tuesday Filled-100"), forState: .Normal)
            self.btnTuesday.tintColor = defaultColor
        }
        if ((self.provider.objectForKey("wednesday") as! Int) == 1){
            self.btnWedneday.setBackgroundImage(UIImage(named: "Wednesday Filled-100"), forState: .Normal)
            self.btnWedneday.tintColor = defaultColor
        }
        if ((self.provider.objectForKey("thursday") as! Int) == 1){
            self.btnThuesday.setBackgroundImage(UIImage(named: "Thursday Filled-100"), forState: .Normal)
            self.btnThuesday.tintColor = defaultColor
        }
        if ((self.provider.objectForKey("friday") as! Int) == 1){
            self.btnFriday.setBackgroundImage(UIImage(named: "Friday Filled-100"), forState: .Normal)
            self.btnFriday.tintColor = defaultColor
        }
        if ((self.provider.objectForKey("saturday") as! Int) == 1){
            self.btnSaturday.setBackgroundImage(UIImage(named: "Saturday Filled-100"), forState: .Normal)
            self.btnSaturday.tintColor = defaultColor
        }
        if ((self.provider.objectForKey("sunday") as! Int) == 1){
            self.btnSunday.setBackgroundImage(UIImage(named: "Sunday Filled-100"), forState: .Normal)
            self.btnSunday.tintColor = defaultColor
        }
        if ((self.provider.objectForKey("morning") as! Int) == 1){
            self.morningImageView.image = UIImage(named: "Sunrise Filled-100")
            self.morningImageView.tintColor = defaultColor
        }
        if ((self.provider.objectForKey("afternoon") as! Int) == 1){
            self.eveningImageView.image = UIImage(named: "Sunset Filled-100")
            self.eveningImageView.tintColor = defaultColor
        }
        if ((self.provider.objectForKey("integral") as! Int) == 1){
            self.fullDayImageView.image = UIImage(named: "day-night_day_night_daynight-512-2")
            self.fullDayImageView.tintColor = defaultColor
        }
        
        
        
        if ((self.provider.objectForKey("cleanTheHouse") as! Int) == 1){
            self.homeCleaningImageView.image = UIImage(named: "Housekeeping Filled-100")
            self.homeCleaningImageView.tintColor = defaultColor
        }
        if ((self.provider.objectForKey("doTheLaundry") as! Int) == 1){
            self.whasingMachineImageView.image = UIImage(named: "Washing Machine-100-2")
            self.whasingMachineImageView.tintColor = defaultColor
        }
        if ((self.provider.objectForKey("ironTheClochtes") as! Int) == 1){
            self.ironImageView.image = UIImage(named: "Iron Filled-100")
            self.ironImageView.tintColor = defaultColor
        }
        if ((self.provider.objectForKey("cook") as! Int) == 1){
            self.kitchenImageView.image = UIImage(named: "Kitchen-100-2")
            self.kitchenImageView.tintColor = defaultColor
        }
        if ((self.provider.objectForKey("otherServices") as! Int) == 1){
            self.moreImageView.image = UIImage(named: "More Filled-100")
            self.moreImageView.tintColor = defaultColor
        }
        
        self.selfDescriptionTextView.text = self.provider.objectForKey("selfDescription") as? String
        
        self.phoneLabel.text = self.provider.objectForKey("contact") as? String
        
        if let userPicture = provider.objectForKey("imageProfile") as? PFFile {
            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error:NSError?) -> Void in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    self.providerImageView.image = image
                }else{
                    print("Error: \(error)")
                }
            }
        }

        
        if let fullName = provider.objectForKey("fullName") as? String{
            self.fullNameLabel.text = fullName
        }else{
            self.fullNameLabel.text = "Nome não cadastrado"
        }
        
    }
    
    @IBAction func avaliability(sender: AnyObject){
        
    }
    
    
    @IBAction func buttonDismiss(sender: AnyObject) {
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            let grow = CGAffineTransformMakeScale(0.5, 0.5)
            let angle = CGFloat(-30)
            let rotate = CGAffineTransformMakeRotation(angle)
            self.btnDismiss.transform = CGAffineTransformConcat(grow, rotate)
            
        }) { (results) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "rateProvider"{
            let destination = segue.destinationViewController as! RatingViewController
            destination.provider = self.provider as PFUser
        }
    }
}
 