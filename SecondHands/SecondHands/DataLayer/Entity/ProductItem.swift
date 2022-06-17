//
//  ItemProduct.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 16/06/22.
//

import Foundation

struct ProductItem: Codable, Hashable {
    let id: String
    let productImage: String
    let productTitle: String
    let productCategory: String
    let productPrice: String
}

struct ProductCategory {
    let id: String
    let productImage: String
    let productTitle: String
    let productCategory: String
}

struct OfferItem {
    let id: String
    let offerImage: String
    let offerTitle: String
    let discount: String
}
