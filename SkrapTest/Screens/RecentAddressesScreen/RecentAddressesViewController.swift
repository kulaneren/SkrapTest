//
//  RecentAddressesViewController.swift
//  SkrapTest
//
//  Created by eren kulan on 24/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import UIKit

class RecentAddressesViewController: UIViewController {
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var tableViewAddresses: UITableView!
    @IBOutlet weak var tableViewSubServices: UITableView!

    private var apiClient = APIClient()
    private var arrayAddresses = [SAddress]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAddresses(withAPIClient: apiClient)
        viewBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerSelector)))

        tableViewAddresses.register(UINib(nibName: "RecentAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentAddressTableViewCellIdentifier")
        tableViewAddresses.estimatedRowHeight = 85.0
        tableViewAddresses.rowHeight = UITableView.automaticDimension
    }

    @objc func tapGestureRecognizerSelector() {
        viewBackground.isHidden = true
        self.dismiss(animated: true, completion: nil)
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
                self.arrayAddresses = addresses
                self.tableViewAddresses.reloadData()
            }
        })
    }
}

extension RecentAddressesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewAddresses {
            return arrayAddresses.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewAddresses {
            let address = arrayAddresses[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentAddressTableViewCellIdentifier") as! RecentAddressTableViewCell
            cell.update(address: address)
            return cell
        } else {
            let address = arrayAddresses[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentAddressTableViewCellIdentifier") as! RecentAddressTableViewCell
            cell.update(address: address)
            return cell
        }
    }
}

extension RecentAddressesViewController: UITableViewDelegate {

}
