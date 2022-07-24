//
//  String+Extension.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 23/07/22.
//

import Foundation

extension String {
    var initials: String {
        return self.components(separatedBy: " ")
            .reduce("") {
                ($0.isEmpty ? "" : "\($0.first?.uppercased() ?? "")") +
                ($1.isEmpty ? "" : "\($1.first?.uppercased() ?? "")")
            }
    }
}
