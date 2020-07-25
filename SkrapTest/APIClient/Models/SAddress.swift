//
//  SAddress.swift
//  SkrapTest
//
//  Created by eren kulan on 24/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import Foundation

enum SAddressCodingKeys: String, CodingKey {
    case postcode, postTown = "post_town", buildingNumber = "building_number", buildingName = "building_name", country
}

struct SAddress: Decodable {
    var postcode: String
    var postTown: String
    var buildingName: String
    var buildingNumber: Int
    var country: String

    init(postcode: String?,
         postTown: String?,
         buildingName: String?,
         buildingNumber: Int?,
         country: String?) {
        self.postcode = postcode ?? "No Postcode"
        self.postTown = postTown ?? "No Town"
        self.buildingName = buildingName ?? "No Building Name"
        self.buildingNumber = buildingNumber ?? 0
        self.country = country ?? "No Country"
    }
}

extension SAddress {

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: SAddressCodingKeys.self)
        let postcode = try values.decodeIfPresent(String.self, forKey: .postcode)
        let postTown = try values.decodeIfPresent(String.self, forKey: .postTown)
        let buildingName = try values.decodeIfPresent(String.self, forKey: .buildingName)
        let buildingNumber = try values.decodeIfPresent(Int.self, forKey: .buildingNumber)
        let country = try values.decodeIfPresent(String.self, forKey: .country)

        self.init(postcode: postcode, postTown: postTown, buildingName: buildingName, buildingNumber: buildingNumber, country: country)
    }
}
