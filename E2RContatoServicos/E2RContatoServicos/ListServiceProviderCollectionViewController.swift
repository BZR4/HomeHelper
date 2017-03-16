//
//  ListServiceProviderCollectionViewController.swift
//  E2RContatoServicos
//
//  Created by Esdras Bezerra da Silva on 15/07/15.
//  Copyright (c) 2015 Rodrigo A E Miyashiro. All rights reserved.
//

import UIKit
import Parse

let reuseIdentifier = "Cell"

class ListServiceProviderCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var providers: [PFUser]!
    
    @IBOutlet weak var btnLogout: UIBarButtonItem!
    
    var allRatingEGood: [Int]!
    var allRatingERegular: [Int]!
    var allRatingEBad: [Int]!
    
    var isLoadedRating: Bool = false
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnLogout.title = (NSLocalizedString("Sair", comment: "the message present in logout button"))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchObjectsFromParse()

        self.allRatingEGood = [Int]()
        self.allRatingERegular = [Int] ()
        self.allRatingEBad = [Int] ()
        
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            print("\n\nThis is run on the background queue")
            
            self.isLoadedRating = false
            
            for aUser in self.providers {
                self.getEvaluation(aUser)
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("This is run on the main queue, after the previous code in outer block")
                
                self.isLoadedRating = true
                self.collectionView?.reloadData()
            })
        })
    }

    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        if toInterfaceOrientation.isLandscape {
            self.flowLayout.scrollDirection = .Horizontal
        } else{
            self.flowLayout.scrollDirection = .Vertical
        }
        collectionView?.setNeedsLayout()
    }
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items in the section
        return self.providers.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ServiceProviderCell
    
        // Configure the cell
        let provider: PFUser = self.providers[indexPath.row]
        
        
        if let name = provider.username {
            cell.nameLabel.text = name
        }
        if let description = provider["selfDescription"] as? String {
            cell.descriptionProvider.text = description
        }
        if let perfilImage = provider ["imageProfile"] as? UIImage{
            cell.imageView.image = perfilImage
        }
        
        // MODIFICAR!!!!
        if self.isLoadedRating {
            let providorRatingEGood = self.allRatingEGood[indexPath.row] as Int
            let providorRatingERegular = self.allRatingERegular[indexPath.row] as Int
            let providorRatingEBad = self.allRatingEBad[indexPath.row] as Int
            
            cell.activityIndicatorRatingBad.stopAnimating()
            cell.activityIndicatorRatingRegular.stopAnimating()
            cell.activityIndicatorRatingGood.stopAnimating()
            
            cell.goodCountLabel?.hidden = false
            cell.regularCountLabel?.hidden = false
            cell.badCountLabel?.hidden = false
            
            cell.goodCountLabel?.text = String(providorRatingEGood > 0 ? providorRatingEGood : 0)
            cell.badCountLabel?.text = String(providorRatingEBad > 0 ? providorRatingEBad : 0)
            cell.regularCountLabel?.text = String(providorRatingERegular > 0 ? providorRatingERegular : 0)
        }
        else {
            
            cell.activityIndicatorRatingBad.startAnimating()
            cell.activityIndicatorRatingRegular.startAnimating()
            cell.activityIndicatorRatingGood.startAnimating()
            
            cell.goodCountLabel?.hidden = true
            cell.regularCountLabel?.hidden = true
            cell.badCountLabel?.hidden = true
        }
        
        
        
        // CRIAR UM METODO PARA TRATAR ISSO!!!!!
        if let userPicture = provider.objectForKey("imageProfile") as? PFFile {
            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error:NSError?) -> Void in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    cell.activityIndicatorImagem.stopAnimating()
                    cell.imageView.image = image
                }else{
                    print("Error: \(error)")
                }
            }
        }
        
        return cell
    }
    
    // Fetch objects in Parse
    func fetchObjectsFromParse(){
        
        let query = PFUser.query()
        query!.whereKey("isServiceProvider", equalTo:true)
        let users = query!.findObjects()

        providers = [PFUser]()  // inicializacao do array com unwraping forcado
        for user in users as! [PFUser]{
            providers.append(user)
        }
    }
    
    
    func getEvaluation(user: PFUser) {
        let query = PFQuery (className: "Evaluation")
        query.whereKey("idObject", equalTo: user.objectId!)
        let eval  = query.findObjects()
        
        var totalEGood:Int = 0
        var totalERegular:Int = 0
        var totalEBad:Int = 0
        
        for user in eval as! [PFObject] {
            if user["eGood"] as? Int == 1 {
                totalEGood += 1
            }
            
            if user["eRegular"] as? Int == 1 {
                totalERegular += 1
            }
            
            if user["eBad"] as? Int == 1 {
                totalEBad += 1
            }
        }

        self.allRatingEGood?.append(totalEGood)
        self.allRatingERegular?.append(totalERegular)
        self.allRatingEBad?.append(totalEBad)
    }
    
    

    @IBAction func logout(sender: AnyObject) {

        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let cell = sender as? UICollectionViewCell {
            
            let indexPath = collectionView?.indexPathForCell(cell)
            let indexItem = indexPath?.item
            
            let destinationController = segue.destinationViewController as! DetailServiceProviderViewController
            destinationController.provider = self.providers[indexItem!] as PFUser
        }
        
        

    }

}
