//
//  ServiceProviderCell.swift
//  E2RContatoServicos
//
//  Created by Esdras Bezerra da Silva on 15/07/15.
//  Copyright (c) 2015 Rodrigo A E Miyashiro. All rights reserved.
//

import UIKit

class ServiceProviderCell: UICollectionViewCell {
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    
    @IBOutlet weak var goodRatingImage: UIImageView!
    @IBOutlet weak var regularRatingImage: UIImageView!
    @IBOutlet weak var badRatingImage: UIImageView!
    
    @IBOutlet weak var descriptionProvider: UITextView!
    
    @IBOutlet weak var goodCountLabel: UILabel!
    @IBOutlet weak var regularCountLabel: UILabel!
    @IBOutlet weak var badCountLabel: UILabel!
    
    @IBOutlet weak var activityIndicatorImagem: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorRatingBad: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorRatingRegular: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorRatingGood: UIActivityIndicatorView!
    
    override func layoutSubviews() {
        imageView.layer.cornerRadius = imageView.frame.width / 2
        background.layer.cornerRadius = 10
        
        
        goodRatingImage.tintColor = UIColor.blackColor()
        goodRatingImage.backgroundColor = UIColor.greenColor()
        goodRatingImage.layer.cornerRadius = goodRatingImage.layer.frame.width / 2
        
        regularRatingImage.tintColor = UIColor.blackColor()
        regularRatingImage.backgroundColor = UIColor.yellowColor()
        regularRatingImage.layer.cornerRadius = regularRatingImage.layer.frame.width / 2
        
        badRatingImage.tintColor = UIColor.blackColor()
        badRatingImage.backgroundColor = UIColor.redColor()
        badRatingImage.layer.cornerRadius = badRatingImage.layer.frame.width / 2
    }
}
