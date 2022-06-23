//
//  Array+Extension.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 23/06/22.
//

import Foundation

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
