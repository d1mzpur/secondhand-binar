//
//  OrderItem.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 7/14/22.
//

import Foundation


// MARK: - OrderItem
struct OrderItem: Codable {
    let id, productID, buyerID, price: Int
    let transactionDate: String?
    let productName, basePrice: String
    let imageProduct: String?
    let status, createdAt, updatedAt: String
    let product: ProductClass
    let user: UserOrder

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case buyerID = "buyer_id"
        case price
        case transactionDate = "transaction_date"
        case productName = "product_name"
        case basePrice = "base_price"
        case imageProduct = "image_product"
        case status, createdAt, updatedAt
        case product = "Product"
        case user = "User"
    }
}

// MARK: - ProductClass
struct ProductClass: Codable {
    let name, productDescription: String
    let basePrice: Int
    let imageURL: String
    let imageName, location: String
    let userID: Int
    let status: String
    let user: UserOrder

    enum CodingKeys: String, CodingKey {
        case name
        case productDescription = "description"
        case basePrice = "base_price"
        case imageURL = "image_url"
        case imageName = "image_name"
        case location
        case userID = "user_id"
        case status
        case user = "User"
    }
}

// MARK: - User
struct UserOrder: Codable {
    let id: Int
    let fullName, email, phoneNumber, address: String
    let city: String

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case email
        case phoneNumber = "phone_number"
        case address, city
    }
}

