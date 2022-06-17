//
//  ItemProduct.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 16/06/22.
//

import Foundation

struct ItemProduct: Codable, Hashable {
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
    let productPrice: String
}
