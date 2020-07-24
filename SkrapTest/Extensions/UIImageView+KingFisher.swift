//
//  UIImageView+KingFisher.swift
//  SkrapTest
//
//  Created by eren kulan on 24/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    func setServiceImageWithURL(url: String) {
        let str = API.URLBaseImage + url
        let url = URL(string: str)
        self.kf.setImage(with: url)
    }
}
