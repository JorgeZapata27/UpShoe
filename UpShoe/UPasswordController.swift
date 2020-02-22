//
//  UPasswordController.swift
//  UpShoe
//
//  Created by JJ Zapata on 2/20/20.
//  Copyright © 2020 Jorge Zapata. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class UPasswordController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet var passwordConfirmTextField : UITextField!
    @IBOutlet var logoImageView : UIImageView!
    
    var firstName = ""
    var lastName = ""
    var email = ""
    var country = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // Hides keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // Return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    
    @IBAction func SignUpPressed(_ sender: UIButton) {
        if self.passwordTextField.text! != "" {
            if self.passwordTextField.text! == self.passwordConfirmTextField.text! {
                if self.passwordTextField.text!.count > 6 {
                    if self.passwordTextField.text! == self.passwordConfirmTextField.text! {
                        Auth.auth().createUser(withEmail: self.email, password: self.passwordConfirmTextField!.text!) { (result, error) in
                            if error != nil {
                                print(self.email)
                                print("Person")
                                let AlertController = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                                AlertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                                self.present(AlertController, animated: true, completion: nil)
                            } else {
                                let uid = Auth.auth().currentUser?.uid
                                Database.database().reference(fromURL: "https://upshoe-a6123.firebaseio.com/").child("Users").child(uid!).child("UserFirstName").setValue(self.firstName)
                                Database.database().reference(fromURL: "https://upshoe-a6123.firebaseio.com/").child("Users").child(uid!).child("UserLastName").setValue(self.lastName)
                                Database.database().reference(fromURL: "https://upshoe-a6123.firebaseio.com/").child("Users").child(uid!).child("UserEmail").setValue(self.email)
                                Database.database().reference(fromURL: "https://upshoe-a6123.firebaseio.com/").child("Users").child(uid!).child("UserLocation").setValue(self.country)
                                Database.database().reference(fromURL: "https://upshoe-a6123.firebaseio.com/").child("Users").child(uid!).child("UserPassword").setValue(self.passwordConfirmTextField.text!)
                                Database.database().reference(fromURL: "https://upshoe-a6123.firebaseio.com/").child("Users").child(uid!).child("Likes").setValue(0)
                                Database.database().reference(fromURL: "https://upshoe-a6123.firebaseio.com/").child("Users").child(uid!).child("Sold").setValue(0)
                                Database.database().reference(fromURL: "https://upshoe-a6123.firebaseio.com/").child("Users").child(uid!).child("Bought").setValue(0)
                                print(self.email)
                                guard let image = self.logoImageView.image else { return }
                                guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
                                let storageRef = Storage.storage().reference(forURL: "gs://upshoe-a6123.appspot.com/")
                                let storageProfileRef = storageRef.child("Profile").child(Auth.auth().currentUser!.uid)
                                let metadata = StorageMetadata()
                                metadata.contentType = "image/jpg"
                                storageProfileRef.putData(imageData, metadata: metadata) { (storageMetadata, errir) in
                                    if error != nil {
                                        print(error!.localizedDescription)
                                        return
                                    }
                                    storageProfileRef.downloadURL { (url, error) in
                                        if let metaImageURL = url?.absoluteString {
                                            Database.database().reference().child("Users").child(uid!).child("UserProfileImage").setValue(metaImageURL)
                                            print("Success")
                                            // Perfom Segue
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        let AlertController = UIAlertController(title: "Password Error", message: "Both Passwords Must Match", preferredStyle: .alert)
                        AlertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        self.present(AlertController, animated: true, completion: nil)
                    }
                } else {
                    let AlertController = UIAlertController(title: "Password Error", message: "Please Enter More Than 6 Digits", preferredStyle: .alert)
                    AlertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    self.present(AlertController, animated: true, completion: nil)
                }
            } else {
                let AlertController = UIAlertController(title: "Password Error", message: "Both Passwords Must Match", preferredStyle: .alert)
                AlertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(AlertController, animated: true, completion: nil)
            }
        } else {
            let AlertController = UIAlertController(title: "Password Error", message: "Please Enter More Than 6 Digits", preferredStyle: .alert)
            AlertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(AlertController, animated: true, completion: nil)
        }
    }

}
