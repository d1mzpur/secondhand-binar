//
//  ItemProduct.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 16/06/22.
//

import Foundation

//struct ResultItem: Hashable {
//    let productItem: [ProductItem]
//    let offerItem: OfferItem
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(productItem)
//    }
//    
//    static func == (lhs: ResultItem, rhs: ResultItem) -> Bool {
//        return lhs.offerItem == rhs.offerItem && lhs.productItem == rhs.productItem
//    }
//}

struct ProductItem: Hashable
{
    let id: String
    let productImage: String
    let productTitle: String
    let productCategory: String
    let productPrice: String
    let productDescription: String
    let sellerLocation: String
    let userId: String
    let statusProduct: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case productImage = "image_url"
        case productTitle = "name"
        case productCategory = "Categories"
        case productPrice = "base_price"
        case productDescription = "description"
        case sellerLocation = "location"
        case userId = "user_id"
        case statusProduct = "status"
        case createdAt = "createdAt"
        case updatedAt = "updateAt"
    }
    static func createData() -> [ProductItem] {
        return [ProductItem(id: "1", productImage: "productImage", productTitle: "Apple Watch", productCategory: "Smart Watch", productPrice: "300.000", productDescription: "", sellerLocation: "Bogor", userId: "", statusProduct: "Available", createdAt: "2000-01-01T00:00:00.000Z", updatedAt: "2000-01-01T00:00:00.000Z"),
                ProductItem(id: "2", productImage: "productImage", productTitle: "Samsung Watch", productCategory: "Smart Watch", productPrice: "400.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "2000-01-01T00:00:00.000Z", updatedAt: "2000-01-01T00:00:00.000Z"),
                ProductItem( id: "3", productImage: "productImage", productTitle: "iPhone 13", productCategory: "Smartphone", productPrice: "500.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: ""),
                ProductItem( id: "4", productImage: "productImage", productTitle: "Samsung Galaxy S20", productCategory: "Smartphone", productPrice: "250.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: ""),
                ProductItem( id: "5", productImage: "productImage", productTitle: "AirPods Pro", productCategory: "Air pods", productPrice: "300.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: ""),
                ProductItem( id: "6", productImage: "productImage", productTitle: "Sony Alpha A6300", productCategory: "Mirrorless", productPrice: "400.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: ""),
                ProductItem(id: "7", productImage: "productImage", productTitle: "Dji Mavic Air", productCategory: "Drone", productPrice: "500.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: ""),
                ProductItem(id: "8", productImage: "productImage", productTitle: "Macbook Pro", productCategory: "Laptop", productPrice: "250.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: ""),
                ProductItem( id: "3", productImage: "productImage", productTitle: "iPhone 13", productCategory: "Smartphone", productPrice: "500.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: ""),
                ProductItem( id: "4", productImage: "productImage", productTitle: "Samsung Galaxy S20", productCategory: "Smartphone", productPrice: "250.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: ""),
                ProductItem( id: "5", productImage: "productImage", productTitle: "AirPods Pro", productCategory: "Air pods", productPrice: "300.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: ""),
                ProductItem( id: "6", productImage: "productImage", productTitle: "Sony Alpha A6300", productCategory: "Mirrorless", productPrice: "400.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: ""),
                ProductItem(id: "7", productImage: "productImage", productTitle: "Dji Mavic Air", productCategory: "Drone", productPrice: "500.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: ""),
                ProductItem(id: "8", productImage: "productImage", productTitle: "Macbook Pro", productCategory: "Laptop", productPrice: "250.000", productDescription: "", sellerLocation: "", userId: "", statusProduct: "", createdAt: "", updatedAt: ""),
        ]
    }
}

struct OfferItem {
    let id: String
    let bannerImage: String
    let bannerTitle: String
    let discount: String
    
    static func createData() -> [OfferItem] {
        return [
            OfferItem(id: "1",
                      bannerImage: "offerImage",
                      bannerTitle: "Bulan Ramadhan\nBanyak Dison",
                      discount: "60%"),
            OfferItem(id: "2",
                      bannerImage: "offerImage",
                      bannerTitle: "Bulan Ramadhan\nBanyak Diskon",
                      discount: "60%")
        ]
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
