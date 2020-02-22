//
//  UHomeCell1.swift
//  UpShoe
//
//  Created by JJ Zapata on 2/21/20.
//  Copyright © 2020 Jorge Zapata. All rights reserved.
//

import UIKit

class UHomeCell1: UITableViewCell {
    
    @IBOutlet var upShoeLabel : UILabel!
    @IBOutlet var upShoeImage : UIImageView!
    @IBOutlet var upShoeView : UIView!
    let images = ["YeezeyClay", "YeezeyClay", "YeezeyClay"]

    override func awakeFromNib() {
        super.awakeFromNib()
        self.upShoeView.layer.cornerRadius = 20
        self.upShoeView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        self.upShoeView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        self.upShoeView.layer.shadowRadius = 1.7
        self.upShoeView.layer.shadowOpacity = 0.45
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
