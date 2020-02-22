//
//  UEmailController.swift
//  UpShoe
//
//  Created by JJ Zapata on 2/20/20.
//  Copyright © 2020 Jorge Zapata. All rights reserved.
//

import UIKit

class UEmailController: UIViewController, UITextFieldDelegate {
    
    var firstName = ""
    var lastName = ""
    
    // MARK: - UITextField
    @IBOutlet var emailTextField : UITextField!

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DelegatesNStartUps()

        // Do any additional setup after loading the view.
    }
    
    private func DelegatesNStartUps() {
        self.emailTextField.delegate = self
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
        if self.emailTextField.text! != "" {
            if self.emailTextField.text.isEmailValid() {
                self.performSegue(withIdentifier: "EmailsDone", sender: self)
            } else {
                let AlertController = UIAlertController(title: "Incorrect Email", message: "This Email Is Not Correct. Please Try Again", preferredStyle: .alert)
                AlertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(AlertController, animated: true, completion: nil)
            }
        } else {
            let AlertController = UIAlertController(title: "Empty Text Field", message: "Your Email Text Field Is Empty", preferredStyle: .alert)
            AlertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(AlertController, animated: true, completion: nil)
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmailsDone" {
            let secondController = segue.destination as! UCountryController
            secondController.firstName = self.firstName
            secondController.lastName = self.lastName
            secondController.email = self.emailTextField.text!
        }
    }

}

extension Optional where Wrapped == String {
    func isEmailValid() -> Bool{
        guard let email = self else { return false }
        let emailPattern = "[A-Za-z-0-9.-_]+@[A-Za-z0-9]+\\.[A-Za-z]{2,3}"
        do{
            let regex = try NSRegularExpression(pattern: emailPattern, options: .caseInsensitive)
            let foundPatters = regex.numberOfMatches(in: email, options: .anchored, range: NSRange(location: 0, length: email.count))
            if foundPatters > 0 {
                return true
            }
        }catch{
            //error
        }
        return false
    }
}
