//
//  UploadViewController.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 3/9/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import FirebaseAuth


class UploadViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        textField.delegate = self
        
    }
    
    
    
    
    
    
    @IBAction func postButton(_ sender: UIBarButtonItem) {
        print("post button pressed")
    }
    
    
    @IBAction func libraryButton(_ sender: UIBarButtonItem) {
        print("library button pressed")
    }
    

    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
        print("camera button pressed")
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        print("cancel button pressed")
    }
    

}

extension UploadViewController: UITextFieldDelegate {
    
}
