//
//  ViewController.swift
//  SkrapTest
//
//  Created by eren kulan on 23/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var apiClient = APIClient()

    private var services = [SService]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getServices(withAPIClient: apiClient)
    }

    internal func getServices(withAPIClient apiClient: APIClient) {
        apiClient.getServices(withCompletion: { services, error in
            if let error = error as NSError? {
                let alertAction = UIAlertAction(title: "Ok",
                                                style: .default,
                                                handler: nil)
                self.showAlert(title: "Error", message: error.localizedDescription, actions: [alertAction])
                return
            }
            if let services = services {
                self.services = services
//                self.tblUsers.reloadData()
            }
        })
    }
}

