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

struct UpdateUserModel: Codable {
    let id: Int?
    let fullName: String?
    let email: String?
    let phoneNumber: Int?
    let address: String?
    let image: String?
    let city: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case email
        case phoneNumber = "phone_number"
        case address
        case image
        case city
    }
}
