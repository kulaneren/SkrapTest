//
//  RecentAddressesViewController.swift
//  SkrapTest
//
//  Created by eren kulan on 24/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import UIKit

class RecentAddressesViewController: UIViewController {

    private var apiClient = APIClient()
    private var arryAddresses = [SAddress]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAddresses(withAPIClient: apiClient)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

   internal func getAddresses(withAPIClient apiClient: APIClient) {
        apiClient.getRecentAdresses(withCompletion: { addresses, error in
            if let error = error as NSError? {
                let alertAction = UIAlertAction(title: "Ok",
                                                style: .default,
                                                handler: nil)
                self.showAlert(title: "Error", message: error.localizedDescription, actions: [alertAction])
                return
            }
            if let addresses = addresses {
                self.arryAddresses = addresses
//                self.collectionServices.reloadData()
            }
        })
    }
}
