//
//  SSubService.swift
//  SkrapTest
//
//  Created by eren kulan on 24/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import Foundation

enum SSubServiceCodingKeys: String, CodingKey {
    case serviceName = "service_name", description, price
}

struct SSubService: Decodable {
    var serviceName: String
    var description: String
    var price: Int

    init(serviceName: String?,
         description: String?,
         price: Int?) {
        self.serviceName = serviceName ?? "No service name"
        self.description = description ?? "No description"
        self.price = price ?? 0
    }
}

extension SSubService {

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: SSubServiceCodingKeys.self)
        let serviceName = try values.decodeIfPresent(String.self, forKey: .serviceName)
        let description = try values.decodeIfPresent(String.self, forKey: .description)
        let price = try values.decodeIfPresent(Int.self, forKey: .price)

        self.init(serviceName: serviceName, description: description, price: price)
    }
}
