//
//  UIViewController+Navigation.swift
//  CheckInApp
//
//  Created by Тимур on 20/02/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

import UIKit

extension UIViewController {
    var wrappedInNavigation: UINavigationController {
        return UINavigationController(rootViewController: self)
    }

    func withTabbarItem(with imageName: String) -> UIViewController {
        let image = UIImage(named: imageName)
        tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: nil)
        return self
    }

    func keyboardFadedOnTap() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard(recognizer:)))
        view.addGestureRecognizer(recognizer)
    }

    @objc func dissmisKeyboard(recognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
}
