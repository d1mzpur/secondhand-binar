//
//  UserLoginModel.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 13/07/22.
//

import Foundation

struct UserLoginModel: Codable {
    let id: Int?
    let name: String?
    let email: String?
    let accessToken: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email
        case accessToken = "access_token"
    }
}
