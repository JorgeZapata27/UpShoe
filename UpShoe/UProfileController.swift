//
//  UProfileController.swift
//  UpShoe
//
//  Created by JJ Zapata on 2/21/20.
//  Copyright © 2020 Jorge Zapata. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class UProfileController: UIViewController {
    
    @IBOutlet var profileImageView : UIImageView!
    @IBOutlet var profileName : UILabel!
    @IBOutlet var profileLocation : UILabel!
    @IBOutlet var profileSold : UILabel!
    @IBOutlet var profileBought : UILabel!
    @IBOutlet var profileLikes : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseRetreive()

        // Do any additional setup after loading the view.
    }
    
    private func FirebaseRetreive() {
        let uid = Auth.auth().currentUser!.uid
        Database.database().reference().child("Users").child(uid).child("UserProfileImage").observe(.value, with: { (data) in
            let name : String = (data.value as? String)!
            self.profileImageView.loadImageUsingCacheWithUrlString(urlString: name)
            debugPrint(name)
            Database.database().reference().child("Users").child(uid).child("UserFirstName").observe(.value, with: { (data) in
                let firstName : String = (data.value as? String)!
                Database.database().reference().child("Users").child(uid).child("UserLastName").observe(.value, with: { (data) in
                    let lastName : String = (data.value as? String)!
                    let fullName = "\(firstName) \(lastName)"
                    self.profileName.text! = fullName
                    Database.database().reference().child("Users").child(uid).child("Sold").observe(.value, with: { (data) in
                        let firstName = (data.value as? Int)
                        self.profileSold.text! = String(firstName!)
                        Database.database().reference().child("Users").child(uid).child("Bought").observe(.value, with: { (data) in
                            let firstName = (data.value as? Int)
                            self.profileBought.text! = String(firstName!)
                            Database.database().reference().child("Users").child(uid).child("Likes").observe(.value, with: { (data) in
                                let firstName = (data.value as? Int)
                                self.profileLikes.text! = String(firstName!)
                                Database.database().reference().child("Users").child(uid).child("UserLocation").observe(.value, with: { (data) in
                                    let lastName : String = (data.value as? String)!
                                    self.profileLocation.text! = lastName
                                })
                            })
                        })
                    })
                })
            })
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
