//
//  Int+Currency.swift
//  SkrapTest
//
//  Created by eren kulan on 25/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import Foundation

extension Int {

    func addCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        return formatter.string(for: self) ?? ""
    }
}
