//
//  SubServiceTableViewCell.swift
//  SkrapTest
//
//  Created by eren kulan on 25/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import UIKit

class SubServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var labelMaterialTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!

    func update(subService: SSubService) {
        labelMaterialTitle.text = subService.serviceName
        let price = subService.price.addCurrency()
        labelPrice.text = price
    }
}
