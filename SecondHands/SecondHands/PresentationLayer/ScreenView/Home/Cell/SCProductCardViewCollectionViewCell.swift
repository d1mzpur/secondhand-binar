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
    }
    
    func configure(item: ProductItem) {
        cardView.productImage.image = UIImage(named: item.productImage)
        cardView.productTitle.text = item.productTitle
        cardView.productCategory.text = item.productCategory
        cardView.productPrice.text = item.productPrice
        cardView.clipsToBounds = true
    }
    
    private func setupConstraint() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cardView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 206).isActive = true
        cardView.widthAnchor.constraint(equalToConstant: 156).isActive = true
//        cardView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
//        cardView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
//        cardView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
//        cardView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
}
