//
//  Photo.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 3/9/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct Photo {
    let imageURL: String
    let caption: String
    let photoId: String
    let listedDate: Date
    let userName: String
    let userId: String
}

extension Photo {
    init(_ dictionary: [String: Any]) {
        self.imageURL = dictionary["imageURL"] as? String ?? "no image url"
        self.caption = dictionary["caption"] as? String ?? "no caption"
        self.photoId = dictionary["photoId"] as? String ?? "no photo id"
        self.listedDate = dictionary["listedDate"] as? Date ?? Date()
        self.userName = dictionary["userName"] as? String ?? "no user name"
        self.userId = dictionary["userId"] as? String ?? "no user id"
    }
}



