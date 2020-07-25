//
//  RecentAddressesViewController.swift
//  SkrapTest
//
//  Created by eren kulan on 24/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import UIKit

private enum SelectedModeType {
    case address
    case subServices
}

class SelectionViewController: UIViewController {
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerMain: UIView!
    @IBOutlet weak var containerAddress: UIStackView!
    @IBOutlet weak var containerSubServices: UIView!

    @IBOutlet weak var viewSelection: UIView!
    @IBOutlet weak var imageViewLike: UIImageView!
    private var labelFeatured: UILabel!

    private var apiClient = APIClient()
    private var arrayAddresses = [SAddress]()
    private var arraySubServices = [SSubService]()
    private var selectedMode: SelectedModeType = .address

    override func viewDidLoad() {
        super.viewDidLoad()
        getAddresses(withAPIClient: apiClient)
        getSubServices(withAPIClient: apiClient)
        updateView()
    }

    func updateView() {
        viewBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerSelector)))
        tableView.register(UINib(nibName: "RecentAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentAddressTableViewCellIdentifier")
        tableView.register(UINib(nibName: "SubServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "SubServiceTableViewCellIdentifier")
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
        containerSubServices.isHidden = true
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
                self.tableView.reloadData()
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

    internal func createAndAnimateLabel(withFrame frame: CGRect, address: SAddress) {
        labelFeatured = UILabel(frame: CGRect(x: frame.origin.x,
                                              y: frame.origin.y,
                                              width: viewSelection.frame.size.width - (viewSelection.frame.size.width - imageViewLike.frame.origin.x) - frame.origin.x,
                                              height: viewSelection.frame.size.height))
        labelFeatured.textAlignment = .left
        labelFeatured.numberOfLines = 1
        labelFeatured.textColor = .darkGray
        labelFeatured.font = UIFont.boldSystemFont(ofSize: 17.0)
        view.addSubview(labelFeatured)
        labelFeatured.text = "\(address.buildingNumber)" + " " +
            address.buildingName + " " +
            address.postTown

        let absoluteOfViewSelection = containerSubServices.convert(viewSelection.frame, to: view)
        let frame = view.convert(labelFeatured.frame, to: viewSelection)
        UIView.animate(withDuration: 0.5, animations: {
            self.labelFeatured.frame.origin.x = frame.origin.x
            self.labelFeatured.frame.origin.y = absoluteOfViewSelection.origin.y
        }, completion: { end in
            let frame = self.view.convert(self.labelFeatured.frame, to: self.viewSelection)
            self.labelFeatured.frame = frame
            self.labelFeatured.removeFromSuperview()
            self.viewSelection.addSubview(self.labelFeatured)
        })
    }
}

extension SelectionViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedMode == .address {
            return arrayAddresses.count
        } else {
            return arraySubServices.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedMode == .address {
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

extension SelectionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedMode == .address {
            UIView.animate(withDuration: 0.5, animations: {
                self.containerSubServices.isHidden = false
                self.containerAddress.isHidden = true
            })
            
            let cell = tableView.cellForRow(at: indexPath) as! RecentAddressTableViewCell
            let rectInSuperview = cell.stackView.convert(cell.lblAddress.frame, to: self.view)
            createAndAnimateLabel(withFrame: rectInSuperview, address: arrayAddresses[indexPath.row])

            selectedMode = .subServices
            tableView.reloadData()
        }
    }
}
