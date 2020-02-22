//
//  ULoginController.swift
//  UpShoe
//
//  Created by JJ Zapata on 2/20/20.
//  Copyright © 2020 Jorge Zapata. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseAuth

class ULoginController: UIViewController, UITextFieldDelegate {
    
    // MARK: - UILabel
    @IBOutlet var upShoeWelcomeLabel : UILabel!
    
    // MARK: - UITextField
    @IBOutlet var emailTextField  : UITextField!
    @IBOutlet var passwordTextField : UITextField!
    
    // MARK: - UIButton
    @IBOutlet var signInButton : UIButton!

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DelegatesNStartUps()

        // Do any additional setup after loading the view.
    }
    
    private func DelegatesNStartUps() {
        self.upShoeWelcomeLabel.text! = "Welcome \nBack!"
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
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
    
    @IBAction func SignInPressed(_ sender: UIButton) {
        if self.emailTextField.text! != "" {
            if self.passwordTextField.text! != "" {
                Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (result, error) in
                    if error != nil {
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    self.navigationController?.pushViewController(UHomeController(), animated: true)
                }
            } else {
                let AlertController = UIAlertController(title: "Empty Text Field", message: "Your Password Text Field Is Empty", preferredStyle: .alert)
                AlertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(AlertController, animated: true, completion: nil)
            }
        } else {
            let AlertController = UIAlertController(title: "Empty Text Field", message: "Your Email Text Field Is Empty", preferredStyle: .alert)
            AlertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(AlertController, animated: true, completion: nil)
        }
        // Dissmiss
    }

}
