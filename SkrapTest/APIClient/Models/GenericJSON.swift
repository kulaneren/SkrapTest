//
//  GenericJSON.swift
//  SkrapTest
//
//  Created by eren kulan on 24/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import Foundation

struct GenericJSON<T: Decodable>: Decodable {
    var code: Int
    var description: String
    var result: [T]
}
