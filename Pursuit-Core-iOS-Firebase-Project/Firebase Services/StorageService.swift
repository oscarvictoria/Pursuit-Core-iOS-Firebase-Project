//
//  StorageService.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 3/9/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation
import FirebaseStorage


class StorageService {
    
    private let storageReference = Storage.storage().reference()
    
    public func uploadPhoto(userId: String? = nil, photoId: String? = nil, image: UIImage, completion: @escaping (Result <URL, Error>)->()) {
        
        // 1. Convert UIImage to Data because this is the object we are posting to fiebase storage
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        // 2. We need to establish which bucket or collection or folder we will be saving the photo to
        
        var photoReferance: StorageReference!
        
        if let userId = userId {
            photoReferance = storageReference.child("UserProfilePhotos/\(userId).jpg")
        } else if let itemId = photoId {
            photoReferance = storageReference.child("ItemsPhotos/\(itemId).jpg")
        }
        
        // 3. Configure metsdata for the object being uploaded
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        let _ = photoReferance.putData(imageData, metadata: metaData) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
            } else if let _ = metadata {
                photoReferance.downloadURL { (url, error) in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url))
                    }
                }
            }
        }
        
    }
}
