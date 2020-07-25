//
//  ViewController.swift
//  SkrapTest
//
//  Created by eren kulan on 23/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import UIKit

class ServicesViewController: UIViewController {

    @IBOutlet weak var collectionServices: UICollectionView!
    private let serviceCollectionCellIdentifier = "ServicesCollectCellIdentifier"
    private var apiClient = APIClient()

    private var arryServices = [SService]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getServices(withAPIClient: apiClient)
        initCollectionView()
        self.title = "Services"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //collectionServices.collectionViewLayout.invalidateLayout()
        collectionServices.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }

//override func viewWillLayoutSubviews() {
//    super.viewWillLayoutSubviews()
//    collectionServices.collectionViewLayout.invalidateLayout()
//}

//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//            collectionServices.collectionViewLayout.invalidateLayout()
//          collectionServices.reloadData()
//    }



    private func initCollectionView() {
        collectionServices.delegate = self
        collectionServices.dataSource = self

        collectionServices.register(UINib(nibName: "ServicesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: serviceCollectionCellIdentifier)
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
                self.arryServices = services
                self.collectionServices.reloadData()
            }
        })
    }
}

extension ServicesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showRecentAddresses", sender: self)
    }
}

extension ServicesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arryServices.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let service = arryServices[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: serviceCollectionCellIdentifier, for: indexPath) as! ServicesCollectionViewCell
        cell.update(content: service)

        return cell
    }
}
