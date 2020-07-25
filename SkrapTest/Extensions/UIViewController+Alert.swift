//
//  UIViewController+Alert.swift
//  SkrapTest
//
//  Created by eren kulan on 23/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(title: String?,
                   message: String?,
                   actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        for alertAction in actions {
            alertController.addAction(alertAction)
        }
        present(alertController, animated: true, completion: nil)
    }
}
