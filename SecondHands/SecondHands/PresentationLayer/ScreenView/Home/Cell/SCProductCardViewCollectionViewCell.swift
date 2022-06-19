//
//  SCProductCardViewCollectionViewCell.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 16/06/22.
//

import UIKit

class SCProductCardViewCollectionViewCell: UICollectionViewCell {
    lazy var cardView = SCProductCard()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(cardView)
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(item: ProductItem) {
        cardView.productImage.image = UIImage(named: item.productImage)
        cardView.productTitle.text = item.productTitle
        cardView.productCategory.text = item.productCategory
        cardView.productPrice.text = item.productPrice
    }
    
    private func setupConstraint() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
}
