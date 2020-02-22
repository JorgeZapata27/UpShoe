//
//  UProfileImageController.swift
//  UpShoe
//
//  Created by JJ Zapata on 2/21/20.
//  Copyright © 2020 Jorge Zapata. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class UProfileImageController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker : UIImagePickerController!
    
    @IBOutlet var upShoeImageView : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uid = Auth.auth().currentUser!.uid
        Database.database().reference().child("Users").child(uid).child("UserProfileImage").observe(.value, with: { (data) in
            let name : String = (data.value as? String)!
            self.upShoeImageView.loadImageUsingCacheWithUrlString(urlString: name)
            debugPrint(name)
        })
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        guard let imageData = upShoeImageView.image?.jpegData(compressionQuality: 0.75) else { return }
        let storageRef = Storage.storage().reference(forURL: "gs://upshoe-a6123.appspot.com/")
        let storageProfileRef = storageRef.child("Profile").child(Auth.auth().currentUser!.uid)
        let metadata = StorageMetadata()
        let uid = Auth.auth().currentUser!.uid
        metadata.contentType = "image/jpg"
        storageProfileRef.putData(imageData, metadata: metadata) { (storageMetadata, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            storageProfileRef.downloadURL { (url, error) in
                if let metaImageURL = url?.absoluteString {
                    print(metaImageURL)
                    Database.database().reference(fromURL: "https://upshoe-a6123.firebaseio.com/").child("Users").child(uid).child("UserProfileImage").setValue(metaImageURL)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changePressed(_ sender: UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.upShoeImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.upShoeImageView.image = originalImage
        }
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
