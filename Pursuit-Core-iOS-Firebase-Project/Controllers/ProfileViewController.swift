//
//  ProfileViewController.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 3/9/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import FirebaseAuth
import Kingfisher

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    
    private let storageService = StorageService()
    
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
        profileImageView.kf.setImage(with: user.photoURL)
        
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
    
    
    
    @IBAction func updateProfileButton(_ sender: UIButton) {
        
        guard let displayName = usernameTextField.text,
            !displayName.isEmpty,
            let selectedImage = selectedImage else {
                print("missong fields")
                return
        }
        
        
        let resizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: profileImageView.bounds)
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        storageService.uploadPhoto(userId: user.uid, image: resizedImage) { (result) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success(let url):
                let request = Auth.auth().currentUser?.createProfileChangeRequest()
                request?.displayName = displayName
                request?.photoURL = url
                request?.commitChanges(completion: { (error) in
                    if let error = error {
                        print("error \(error)")
                    } else {
                      print("succesfully updated storage")
                    }
                })
                
                
            }
        }
        
         let request = Auth.auth().currentUser?.createProfileChangeRequest()
        
        request?.displayName = displayName
        
        request?.commitChanges(completion: { (error) in
                 if let error = error {
                     print("error \(error)")
                 } else {
                     print("succesfully updated profile")
                 }
             })
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
