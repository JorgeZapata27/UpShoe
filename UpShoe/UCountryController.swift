//
//  UCountryController.swift
//  UpShoe
//
//  Created by JJ Zapata on 2/20/20.
//  Copyright © 2020 Jorge Zapata. All rights reserved.
//

import UIKit

class UCountryController: UIViewController {
    
    @IBOutlet var countryTextField : UITextField!
        
    var LpickerView = UIPickerView()
    var countries: [String] = []
    var firstName = ""
    var lastName = ""
    var email = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TextFieldInitiation()

        // Do any additional setup after loading the view.
    }
    
    private func TextFieldInitiation() {
        for code in NSLocale.isoCountryCodes  {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
        
        countryTextField.inputView = LpickerView
        LpickerView.delegate = self
        LpickerView.dataSource = self
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
        if self.countryTextField.text! != "" {
            self.performSegue(withIdentifier: "CounntriesDone", sender: self)
        } else {
            let AlertController = UIAlertController(title: "Country Not Chosen", message: "Please Choose Your Country", preferredStyle: .alert)
            AlertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(AlertController, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CounntriesDone" {
            let secondController = segue.destination as! UPasswordController
            secondController.firstName = self.firstName
            secondController.lastName = self.lastName
            secondController.email = self.email
            secondController.country = self.countryTextField.text!
        }
    }

}

extension UCountryController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryTextField.text = countries[row]
    }
}
