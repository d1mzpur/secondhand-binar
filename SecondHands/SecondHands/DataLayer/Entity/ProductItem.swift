//
//  ItemProduct.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 16/06/22.
//

import Foundation

struct Categories: Codable {
    let id: Int?
    let name: String?
    let createdAt: String?
    let updatedAt: String?
}

struct ProductItem: Codable {
    let id: Int?
    let productImage: String?
    let productTitle: String?
    let productPrice: Int?
    let productDescription: String?
    let sellerLocation: String?
    let userId: Int?
    let statusProduct: String?
    let createdAt: String?
    let updatedAt: String?
    let productCategory: [Categories]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case productImage = "image_url"
        case productTitle = "name"
        case productPrice = "base_price"
        case productDescription = "description"
        case sellerLocation = "location"
        case userId = "user_id"
        case statusProduct = "status"
        case createdAt = "createdAt"
        case updatedAt = "updateAt"
        case productCategory = "Categories"
    }
}

struct reponseProduct: Codable {
    let id: Int?
    let name, productDescription: String
    let basePrice: Int
    let imageURL: String
    let imageName, location: String
    let userID: Int
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case productDescription = "description"
        case basePrice = "base_price"
        case imageURL = "image_url"
        case imageName = "image_name"
        case location
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
//    static func createData() -> [ProductItem] {
//        return [ProductItem(id: "1", productImage: "productImage", productTitle: "Apple Watch", productCategory: "Smart Watch", productPrice: "300.000", productDescription: "", sellerLocation: "Bogor", userId: "", statusProduct: "Available", createdAt: "2000-01-01T00:00:00.000Z", updatedAt: "2000-01-01T00:00:00.000Z", categories: [Categories(id: 1, name: "")]),
//                ProductItem(id: "2", productImage: "productImage", productTitle: "Samsung Watch", productCategory: "Smart Watch", productPrice: "400.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "2000-01-01T00:00:00.000Z", updatedAt: "2000-01-01T00:00:00.000Z", categories: [Categories(id: 1, name: "")]),
//                ProductItem( id: "3", productImage: "productImage", productTitle: "iPhone 13", productCategory: "Smartphone", productPrice: "500.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: "", categories: [Categories(id: 1, name: "")]),
//                ProductItem( id: "4", productImage: "productImage", productTitle: "Samsung Galaxy S20", productCategory: "Smartphone", productPrice: "250.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: "", categories: [Categories(id: 1, name: "")]),
//                ProductItem( id: "5", productImage: "productImage", productTitle: "AirPods Pro", productCategory: "Air pods", productPrice: "300.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: "", categories: [Categories(id: 1, name: "")]),
//                ProductItem( id: "6", productImage: "productImage", productTitle: "Sony Alpha A6300", productCategory: "Mirrorless", productPrice: "400.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: "", categories: [Categories(id: 1, name: "")]),
//                ProductItem(id: "7", productImage: "productImage", productTitle: "Dji Mavic Air", productCategory: "Drone", productPrice: "500.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: "", categories: [Categories(id: 1, name: "")]),
//                ProductItem(id: "8", productImage: "productImage", productTitle: "Macbook Pro", productCategory: "Laptop", productPrice: "250.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: "", categories: [Categories(id: 1, name: "")]),
//                ProductItem( id: "3", productImage: "productImage", productTitle: "iPhone 13", productCategory: "Smartphone", productPrice: "500.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: "", categories: [Categories(id: 1, name: "")]),
//                ProductItem( id: "4", productImage: "productImage", productTitle: "Samsung Galaxy S20", productCategory: "Smartphone", productPrice: "250.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: "", categories: [Categories(id: 1, name: "")]),
//                ProductItem( id: "5", productImage: "productImage", productTitle: "AirPods Pro", productCategory: "Air pods", productPrice: "300.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: "", categories: [Categories(id: 1, name: "")]),
//                ProductItem( id: "6", productImage: "productImage", productTitle: "Sony Alpha A6300", productCategory: "Mirrorless", productPrice: "400.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: "", categories: [Categories(id: 1, name: "")]),
//                ProductItem(id: "7", productImage: "productImage", productTitle: "Dji Mavic Air", productCategory: "Drone", productPrice: "500.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: "", categories: [Categories(id: 1, name: "")]),
//                ProductItem(id: "8", productImage: "productImage", productTitle: "Macbook Pro", productCategory: "Laptop", productPrice: "250.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: "", categories: [Categories(id: 1, name: "")]),
//        ]
//    }

