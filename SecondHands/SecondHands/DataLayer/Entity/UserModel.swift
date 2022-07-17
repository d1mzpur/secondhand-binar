//
//  UserModel.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 16/07/22.
//

import Foundation

struct UserRegister: Codable {
    let id: Int?
    let fullName: String?
    let email: String?
    let password: String?
    let phoneNumber: Int?
    let address: String?
    let imageUrl: String?
    let city: String?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case email, password
        case phoneNumber = "phone_number"
        case address
        case imageUrl = "image_url"
        case city, createdAt, updatedAt
    }
}


struct User {
    let imageUser: String
    let userName: String
    let city: String
    
    static func createData() -> User {
        return User(imageUser: "productImage", userName: "Nama Penjual", city: "Kota")
    }
    
}
