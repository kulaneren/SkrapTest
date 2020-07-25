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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
