//
//  Service.swift
//  SkrapTest
//
//  Created by eren kulan on 23/07/2020.
//  Copyright © 2020 eren kulan. All rights reserved.
//

import Foundation

struct GenericJSON: Decodable {
    var code: Int
    var description: String
    var result: [SService]
}

enum SServiceCodingKeys: String, CodingKey {
    case id = "service_id", name = "service_name", description, imgUrl = "img_url"
}

struct SService: Decodable {
    var id: Int
    var name: String
    var description: String
    var imgUrl: String

    init(id: Int?,
         name: String?,
         description: String?,
         imgUrl: String?) {
        self.id = id ?? 0
        self.name = name ?? "No name"
        self.description = description ?? "No Description"
        self.imgUrl = imgUrl ?? "No URL"
    }
}

extension SService {

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: SServiceCodingKeys.self)
        let userId = try values.decodeIfPresent(Int.self, forKey: .id)
        let name = try values.decodeIfPresent(String.self, forKey: .name)
        let imgUrl = try values.decodeIfPresent(String.self, forKey: .imgUrl)
        let description = try values.decodeIfPresent(String.self, forKey: .description)

        self.init(id: userId, name: name, description: description, imgUrl: imgUrl)
    }

}




