//
//  CategorySectionCollectionReusableView.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 16/06/22.
//

import UIKit

class CategorySectionCollectionReusableView: UICollectionReusableView {
    lazy var label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.font = SCLabel(frame: .zero, weight: .medium, size: 14).font
        label.text = "Telusuri Kategori"
        label.frame = bounds
        addSubview(label)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
