//
//  Database Service.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 3/9/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

private let db = Firestore.firestore() // reference to FirebaseFirestore database

class DatabaseService {
    static let photoCollections = "photos"
    
    public func createPhoto(caption: String, displayName: String, completion: @escaping (Result <String, Error>)->()) {
        
        guard let user = Auth.auth().currentUser else { return }
        
        let documentRef = db.collection(DatabaseService.photoCollections).document()
        
        db.collection(DatabaseService.photoCollections).document(documentRef.documentID).setData(["caption" : caption, "postedDate": Timestamp(date: Date()), "userName": displayName, "userId:": user.uid]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(documentRef.documentID))
            }
        }
        
    }
}
