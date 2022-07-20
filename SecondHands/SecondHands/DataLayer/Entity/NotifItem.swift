//
//  NotifItem.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 7/16/22.
//

import Foundation

// MARK: - NotifItem
struct NotifItem: Codable {
    let id, productID: Int
    let productName, basePrice: String
    let bidPrice: Int?
    let imageURL: String
    let transactionDate: String?
    let status: ProductStatusEnum
    let sellerName: String
    let buyerName: String?
    let receiverID: Int
    let read: Bool
    let notificationType: NotificationType?
    let orderID: Int?
    let createdAt, updatedAt: String
    let product: ProductNotifClass?
    let user: UserNotif

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case productName = "product_name"
        case basePrice = "base_price"
        case bidPrice = "bid_price"
        case imageURL = "image_url"
        case transactionDate = "transaction_date"
        case status
        case sellerName = "seller_name"
        case buyerName = "buyer_name"
        case receiverID = "receiver_id"
        case read
        case notificationType = "notification_type"
        case orderID = "order_id"
        case createdAt, updatedAt
        case product = "Product"
        case user = "User"
    }
}

enum NotificationType: String, Codable {
    case buyer = "buyer"
    case seller = "seller"
    case all = ""
}

// MARK: - ProductClass
struct ProductNotifClass: Codable {
    let id: Int
    let name, productDescription: String
    let basePrice: Int
    let imageURL: String
    let imageName, location: String
    let userID: Int
    let status: ProductStatus
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case productDescription = "description"
        case basePrice = "base_price"
        case imageURL = "image_url"
        case imageName = "image_name"
        case location
        case userID = "user_id"
        case status, createdAt, updatedAt
    }
}

enum ProductStatus: String, Codable {
    case available = "available"
    case seller = "seller"
    case sold = "sold"
}


enum ProductStatusEnum: String, Codable {
    case bid = "bid"
    case create = "create"
    case accepted = "accepted"
    case declined = "declined"
}

// MARK: - User
struct UserNotif: Codable {
    let id: Int
    let fullName: String
    let email: String
    let phoneNumber: String
    let address: String
    let imageURL: String
    let city: String

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case email
        case phoneNumber = "phone_number"
        case address
        case imageURL = "image_url"
        case city
    }
}
