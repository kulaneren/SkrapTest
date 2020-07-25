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
    @IBOutlet weak var addressesContainer: UIView!
    @IBOutlet weak var subServicesContainer: UIView!
    
    @IBOutlet weak var viewSelection: UIView!
    @IBOutlet weak var labelSelection: UILabel!

    private var apiClient = APIClient()
    private var arrayAddresses = [SAddress]()
    private var arraySubServices = [SSubService]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAddresses(withAPIClient: apiClient)
        getSubServices(withAPIClient: apiClient)
        updateView()
    }

    func updateView() {
        viewBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerSelector)))
        tableViewAddresses.register(UINib(nibName: "RecentAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentAddressTableViewCellIdentifier")
        tableViewAddresses.estimatedRowHeight = 85.0
        tableViewAddresses.rowHeight = UITableView.automaticDimension

        tableViewSubServices.register(UINib(nibName: "SubServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "SubServiceTableViewCellIdentifier")
        tableViewSubServices.estimatedRowHeight = 85.0
        tableViewSubServices.rowHeight = UITableView.automaticDimension
        subServicesContainer.isHidden = true
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

    internal func getSubServices(withAPIClient apiClient: APIClient) {
        apiClient.getSubServices(withCompletion: { subServices, error in
            if let error = error as NSError? {
                let alertAction = UIAlertAction(title: "Ok",
                                                style: .default,
                                                handler: nil)
                self.showAlert(title: "Error", message: error.localizedDescription, actions: [alertAction])
                return
            }
            if let subServices = subServices {
                self.arraySubServices = subServices
            }
        })
    }
}

extension RecentAddressesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewAddresses {
            return arrayAddresses.count
        } else {
            return arraySubServices.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewAddresses {
            let address = arrayAddresses[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentAddressTableViewCellIdentifier") as! RecentAddressTableViewCell
            cell.update(address: address)
            return cell
        } else {
            let subService = arraySubServices[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubServiceTableViewCellIdentifier") as! SubServiceTableViewCell
            cell.update(subService: subService)
            return cell
        }
    }
}

extension RecentAddressesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addressesContainer.isHidden = true
        subServicesContainer.isHidden = false
        tableViewSubServices.reloadData()
    }
}
