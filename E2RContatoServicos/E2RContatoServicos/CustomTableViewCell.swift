//
//  CustomTableViewCell.swift
//  E2RContatoServicos
//
//  Created by Esdras Bezerra da Silva on 16/07/15.
//  Copyright (c) 2015 Rodrigo A E Miyashiro. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonDay: UIButton!
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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clicButton(){
        print("Clic")
        self.btnTuesday.backgroundColor = UIColor.blueColor()
        self.btnMonday.tintColor = UIColor.greenColor()
    }

}
