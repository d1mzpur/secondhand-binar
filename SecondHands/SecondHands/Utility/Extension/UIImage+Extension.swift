//
//  UIImage+Extension.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 6/17/22.
//

import UIKit

extension UIImage {
    
    func resizeImageTo(size: CGSize) -> UIImage? {
        return UIGraphicsImageRenderer(size: size).image { _ in
                   draw(in: CGRect(origin: .zero, size: size))
               }
    }
}

