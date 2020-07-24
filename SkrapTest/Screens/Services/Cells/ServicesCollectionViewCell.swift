//
//  ServicesCollectionViewCell.swift
//  SkrapTest
//
//  Created by eren kulan on 24/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import UIKit

class ServicesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.blue.cgColor
    }

    func update(content service: SService) {
        imgBackground.setServiceImageWithURL(url: service.imgUrl)
        lblTitle.text = service.name
    }

}
