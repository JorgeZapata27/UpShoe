//
//  ViewController.swift
//  UpShoe
//
//  Created by JJ Zapata on 2/20/20.
//  Copyright © 2020 Jorge Zapata. All rights reserved.
//

import UIKit

class UChooseController: UIViewController {
    
    // MARK: - UILabel
    @IBOutlet var upShoeLabel : UILabel!
    @IBOutlet var upShoeDescr : UILabel!
    
    // MARK: - UIImageView
    @IBOutlet var upShoeImage : UIImageView!
    
    // MARK: - UIButton
    @IBOutlet var upShoeLoginButton : UIButton!
    @IBOutlet var upShoeSignUpButton : UIButton!

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Functions To Throw
        self.startUp()
        self.animateObjects()
        
        // Do any additional setup after loading the view.
    }
    
    private func startUp() {
        self.upShoeLabel.alpha = 0
        self.upShoeDescr.alpha = 0
        self.upShoeImage.alpha = 0
    }
    
    private func animateObjects() {
        UIView.animate(withDuration: 2.25, delay: 0.25, usingSpringWithDamping: 5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.upShoeLabel.alpha = 1
            self.upShoeDescr.alpha = 1
            self.upShoeImage.alpha = 1
            self.upShoeLoginButton.frame.origin.y -= 100
            self.upShoeSignUpButton.frame.origin.y -= 100
        }, completion: nil)
    }


}

