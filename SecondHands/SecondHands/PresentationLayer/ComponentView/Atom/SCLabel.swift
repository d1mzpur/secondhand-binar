//
//  SCLabel.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 6/14/22.
//

import UIKit

class SCLabel: UILabel {
    enum Weight: String {
        case light = "Poppins-Light"
        case regular = "Poppins-Regular"
        case bold = "Poppins-Bold"
    }
    private var weight: Weight = .regular
    private var size: CGFloat = 14
    
    init(frame: CGRect = CGRect.zero, weight: Weight = .regular, size:CGFloat = 14) {
        super.init(frame: frame)
        self.weight = weight
        self.size = size
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // This will call `awakeFromNib` in your code
        setup()
    }
    
    private func setup() {
        self.textColor = .black
        self.font = UIFont(name: weight.rawValue, size: size)
    }
}
