//
//  USignUpController.swift
//  UpShoe
//
//  Created by JJ Zapata on 2/20/20.
//  Copyright © 2020 Jorge Zapata. All rights reserved.
//

import UIKit

class USignUpController: UIViewController, UITextFieldDelegate {

    // MARK: - UITextField
    @IBOutlet var firstNameTextField  : UITextField!
    @IBOutlet var lastNameTextField : UITextField!

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DelegatesNStartUps()

        // Do any additional setup after loading the view.
    }
    
    private func DelegatesNStartUps() {
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
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
        if self.firstNameTextField.text! != "" {
            if self.lastNameTextField.text! != "" {
                performSegue(withIdentifier: "NamesDone", sender: self)
            } else {
                let AlertController = UIAlertController(title: "Empty Text Field", message: "Your Last Name Text Field Is Empty", preferredStyle: .alert)
                AlertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(AlertController, animated: true, completion: nil)
            }
        } else {
            let AlertController = UIAlertController(title: "Empty Text Field", message: "Your First Name Text Field Is Empty", preferredStyle: .alert)
            AlertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(AlertController, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NamesDone" {
            let secondController = segue.destination as! UEmailController
            secondController.firstName = self.firstNameTextField.text!
            secondController.lastName = self.lastNameTextField.text!
        }
    }

}
