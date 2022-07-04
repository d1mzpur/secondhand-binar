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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.dropShadow(type: .low)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardView.dropShadow(type: .low)
        cardView.productImage.image = nil
        cardView.productTitle.text = ""
        cardView.productPrice.text = ""
        cardView.productCategory.text = ""
    }
    
    func configure(item: ProductItem) {
        cardView.productImage.loadImage(resource: item.productImage)
        cardView.productTitle.text = item.productTitle
//        cardView.productCategory.text = item.productCategory
        cardView.productPrice.text = "\(item.productPrice!)"
        cardView.clipsToBounds = true
    }
    
    private func setupConstraint() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cardView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 206 * 1.2).isActive = true
        cardView.widthAnchor.constraint(equalToConstant: 156 * 1.2).isActive = true
    }
}
