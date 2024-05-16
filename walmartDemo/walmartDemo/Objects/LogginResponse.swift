//
//  LogginResponse.swift
//  walmartDemo
//
//  Created by Axel Iván Solano González on 13/05/24.
//

import Foundation
struct LogginResponse: Codable {
    let prefix: String?
    let token: String?
    let success: Bool?
    let message: String?
    let details: LogginDetails
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.prefix = try values.decode(String.self, forKey: .prefix)
        self.token = try values.decode(String.self, forKey: .token)
        self.success = try values.decode(Bool.self, forKey: .success)
        self.message = try values.decode(String.self, forKey: .message)
        self.details = try values.decode(LogginDetails.self, forKey: .details)
        UserDefaults.standard.set(self.token,forKey:"authToken")
    }
}

struct LogginDetails: Codable {
    let created: String?
    let expirationTime: String?
    let active: Bool?
    let authorities: [String]?
    let username: String?
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.created = try values.decode(String.self, forKey: .created)
        self.expirationTime = try values.decode(String.self, forKey: .expirationTime)
        self.active = try values.decode(Bool.self, forKey: .active)
        self.authorities = try values.decode([String].self, forKey: .authorities)
        self.username = try values.decode(String.self, forKey: .username)
    }
}
