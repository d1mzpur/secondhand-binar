//
//  OfferItem.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 03/07/22.
//

import Foundation

struct OfferItem: Codable {
    let bannerId: Int
    let bannerImage: String
    let bannerTitle: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case bannerId = "id"
        case bannerImage = "image_url"
        case bannerTitle = "name"
        case createdAt
        case updatedAt
    }
//    static func createData() -> [OfferItem] {
//        return [
//            OfferItem(id: "1",
//                      bannerImage: "offerImage",
//                      bannerTitle: "Bulan Ramadhan\nBanyak Dison",
//                      discount: "60%"),
//            OfferItem(id: "2",
//                      bannerImage: "offerImage",
//                      bannerTitle: "Bulan Ramadhan\nBanyak Diskon",
//                      discount: "60%")
//        ]
//    }
}
