//
//  Int+Extension.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 24/07/22.
//

import Foundation

extension Int {
    func formatter() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.numberStyle = .decimal
        
        return formatter.string(from: self as NSNumber)!.capitalized
    }
}
