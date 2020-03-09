//
//  ProfileViewController.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 3/9/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    
    private lazy var imagePickerController: UIImagePickerController = {
         let ip = UIImagePickerController()
         ip.delegate = self
         return ip
     }()
    
    private var selectedImage: UIImage? {
           didSet {
               profileImageView.image = selectedImage
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        usernameTextField.delegate = self
        updateUI()
    }
    
    private func updateUI() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        emailLabel.text = user.email
        usernameTextField.text = user.displayName
    }
    
    
    
    @IBAction func editProfileButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose Photo Option", message: nil, preferredStyle: .actionSheet)
          let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: nil)
          let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { alertAction in
              self.imagePickerController.sourceType = .photoLibrary
              self.present(self.imagePickerController, animated: true)
          }
          let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
          if UIImagePickerController.isSourceTypeAvailable(.camera) {
              alertController.addAction(cameraAction)
          }
          
          alertController.addAction(cameraAction)
          alertController.addAction(photoLibraryAction)
          alertController.addAction(cancelAction)
          present(alertController, animated: true)
    }
    
    
    
    
    @IBAction func signoutButton(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            UIViewController.showViewController(storyboardName: "Login", viewControllerId: "LoginViewController")
        } catch {
            print("could not sign out")
        }
    }
    


}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        selectedImage = image
        dismiss(animated: true, completion: nil)
    }
}
