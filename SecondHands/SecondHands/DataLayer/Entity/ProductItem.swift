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

struct ProductItem: Hashable {
    let id: String
    let productImage: String
    let productTitle: String
    let productCategory: String
    let productPrice: String
    }

struct OfferItem: Hashable {
    let id: String
    let bannerImage: String
    let bannerTitle: String
    let discount: String
}
