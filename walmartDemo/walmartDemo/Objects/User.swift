//
//  User.swift
//  walmartDemo
//
//  Created by Axel Iván Solano González on 13/05/24.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let name: String
    let imageURL: String?
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.email = try values.decode(String.self, forKey: .email)
        self.name = try values.decode(String.self, forKey: .name)
        self.imageURL = try values.decode(String.self, forKey: .imageURL)
    }
}
