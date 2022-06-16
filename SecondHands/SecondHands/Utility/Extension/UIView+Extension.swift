//
//  UIView+Extension.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 6/15/22.
//

import UIKit

extension UIView {

    enum ShadowType: CGFloat {
        case low = 2
        case high = 6
    }
        
    func dropShadow(type: ShadowType = .high ) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = type.rawValue
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach{
            addSubview($0)
        }
    }
    
    func setTranslatesAutoresizingMaskIntoConstraintsToFalse(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func addAction(_ selector: Selector, target: AnyObject) {
        isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: target, action: selector)
        self.addGestureRecognizer(gesture)
    }
}
