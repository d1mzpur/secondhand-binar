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
    
    static func createData() -> [ProductItem] {
        return [ProductItem(id: "1", productImage: "productImage", productTitle: "Apple Watch", productCategory: "Smart Watch", productPrice: "300.000"),
                ProductItem(id: "2", productImage: "productImage", productTitle: "Samsung Watch", productCategory: "Smart Watch", productPrice: "400.000"),
                ProductItem( id: "3", productImage: "productImage", productTitle: "iPhone 13", productCategory: "Smartphone", productPrice: "500.000"),
                ProductItem( id: "4", productImage: "productImage", productTitle: "Samsung Galaxy S20", productCategory: "Smartphone", productPrice: "250.000"),
                ProductItem( id: "5", productImage: "productImage", productTitle: "AirPods Pro", productCategory: "Air pods", productPrice: "300.000"),
                ProductItem( id: "6", productImage: "productImage", productTitle: "Sony Alpha A6300", productCategory: "Mirrorless", productPrice: "400.000"),
                ProductItem(id: "7", productImage: "productImage", productTitle: "Dji Mavic Air", productCategory: "Drone", productPrice: "500.000"),
                ProductItem(id: "8", productImage: "productImage", productTitle: "Macbook Pro", productCategory: "Laptop", productPrice: "250.000"),
                ProductItem( id: "3", productImage: "productImage", productTitle: "iPhone 13", productCategory: "Smartphone", productPrice: "500.000"),
                ProductItem( id: "4", productImage: "productImage", productTitle: "Samsung Galaxy S20", productCategory: "Smartphone", productPrice: "250.000"),
                ProductItem( id: "5", productImage: "productImage", productTitle: "AirPods Pro", productCategory: "Air pods", productPrice: "300.000"),
                ProductItem( id: "6", productImage: "productImage", productTitle: "Sony Alpha A6300", productCategory: "Mirrorless", productPrice: "400.000"),
                ProductItem(id: "7", productImage: "productImage", productTitle: "Dji Mavic Air", productCategory: "Drone", productPrice: "500.000"),
                ProductItem(id: "8", productImage: "productImage", productTitle: "Macbook Pro", productCategory: "Laptop", productPrice: "250.000"),
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
