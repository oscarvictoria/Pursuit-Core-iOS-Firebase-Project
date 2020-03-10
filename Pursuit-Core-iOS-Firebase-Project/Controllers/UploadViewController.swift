//
//  UploadViewController.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 3/9/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class UploadViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    private let dbService = DatabaseService()
      
    private let storageService = StorageService()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    private var selectedImage: UIImage? {
        didSet {
            imageView.image = selectedImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        textField.delegate = self
        
    }
    
    
    
    
    
    
    @IBAction func postButton(_ sender: UIBarButtonItem) {
        
        guard let caption = textField.text,
            !caption.isEmpty,
            let selectedImage = selectedImage else {
                print("missing fields")
                return
        }
        
        guard let displayName = Auth.auth().currentUser?.displayName else {
            print("Incomplete Profile")
            return
        }
        
          let resizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: imageView.bounds)
        
        
        dbService.createPhoto(caption: caption, displayName: displayName) { (result) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success(let documentId):
                self.uploadPhoto(photo: resizedImage, documentdId: documentId)
            }
        }

    }
    
    private func uploadPhoto(photo: UIImage, documentdId: String) {
        storageService.uploadPhoto(photoId: documentdId, image: photo) { (result) in
            switch result {
            case .failure(let error):
                print("error uploading photo \(error)")
            case .success(let url):
                self.updatePhotoImageURL(url, documentsId: documentdId)
            }
        }
    }
    
    private func updatePhotoImageURL(_ url: URL, documentsId: String) {
        Firestore.firestore().collection(DatabaseService.photoCollections).document(documentsId).updateData(["imageURL" : url.absoluteString]) { (error) in
            if let error = error {
               print("error \(error)")
            } else {
                print("all went well with the update")
            }
        }

    }
    
    
    @IBAction func libraryButton(_ sender: UIBarButtonItem) {
        showImageController(isCameraSelected: false)
    }
    
    
    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("camera selected")
            showImageController(isCameraSelected: true)
        } else {
            print("camera not available")
        }
        
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        selectedImage = nil
        textField.text = ""
    }
    
    
    private func showImageController(isCameraSelected: Bool) {
        imagePickerController.sourceType = .photoLibrary
        if isCameraSelected {
            imagePickerController.sourceType = .camera
        }
        present(imagePickerController, animated: true)
    }
    
}

extension UploadViewController: UITextFieldDelegate {
    
}

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("could not attain original image")
        }
        selectedImage = image
        dismiss(animated: true, completion: nil)
    }
}
