//
//  RecentAddressTableViewCell.swift
//  SkrapTest
//
//  Created by eren kulan on 25/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import UIKit

class RecentAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    func update(address: SAddress) {
        self.lblAddress.text = "\(address.buildingNumber)" + " " + address.buildingName
        self.lblDetail.text = address.country + " " + address.postTown + " " + address.postcode
    }
}
