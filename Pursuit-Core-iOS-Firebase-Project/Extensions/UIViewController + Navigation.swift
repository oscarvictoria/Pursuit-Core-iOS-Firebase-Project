//
//  UIViewController + Navigation.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 3/9/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

extension UIViewController {
    private static func resetWindow(with rootViewController: UIViewController ) {
        guard let scene = UIApplication.shared.connectedScenes.first,
            let sceneDelegate = scene.delegate as? SceneDelegate,
            let window = sceneDelegate.window else {
                fatalError("could not reset window rootViewController")
        }
        
        window.rootViewController = rootViewController
    }
    
    public static func showViewController(storyboardName: String, viewControllerId: String) {
         let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
         let newViewController = storyboard.instantiateViewController(identifier: viewControllerId)
         resetWindow(with: newViewController)
     }
}


