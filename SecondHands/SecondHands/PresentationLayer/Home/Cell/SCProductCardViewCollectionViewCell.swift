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
    
    func setup(item: ItemProduct) {
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

class CardViewCollectionViewCell: UICollectionViewCell {
    lazy var container: UIView = UIView()
    
    lazy var productImage: UIImageView = {
        var productImage = UIImageView()
        productImage.widthAnchor.constraint(equalToConstant: 140).isActive = true
        productImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        productImage.contentMode = .scaleAspectFill
        productImage.clipsToBounds = true
        
        return productImage
    }()
    
    lazy var productTitle: UILabel = {
        var productTitle = UILabel()
        productTitle.font = SCLabel(frame: .zero, weight: .regular, size: 14).font
        productTitle.textColor = UIColor(red: 0.082, green: 0.082, blue: 0.082, alpha: 1)
        return productTitle
    }()
    
    lazy var productCategory: UILabel = {
        var productCategory = UILabel()
        productCategory.font = SCLabel(frame: .zero, weight: .regular, size: 10).font
        productCategory.textColor = UIColor(red: 0.541, green: 0.541, blue: 0.541, alpha: 1)
        return productCategory
    }()
    
    lazy var productPrice: UILabel = {
        var productPrice = UILabel()
        productPrice.font = SCLabel(frame: .zero, weight: .regular, size: 14).font
        productPrice.textColor = UIColor(red: 0.082, green: 0.082, blue: 0.082, alpha: 1)
        return productPrice
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupConstraint()
    }
    
    func setup(item: ItemProduct) {
        productImage.image = UIImage(named: item.productImage)
        productTitle.text = item.productTitle
        productCategory.text = item.productCategory
        productPrice.text = item.productPrice
    }
    
    private func addSubview() {
        self.addSubview(container)
        container.addSubview(productImage)
        container.addSubview(productTitle)
        container.addSubview(productCategory)
        container.addSubview(productPrice)
    }
    
    func createRounded(radius: CGFloat) -> CardViewCollectionViewCell {
        container.layer.cornerRadius = radius
        productImage.layer.cornerRadius = radius
        return self
    }
    
    private func setupConstraint() {
        container.translatesAutoresizingMaskIntoConstraints = false
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productTitle.translatesAutoresizingMaskIntoConstraints = false
        productCategory.translatesAutoresizingMaskIntoConstraints = false
        productPrice.translatesAutoresizingMaskIntoConstraints = false
        
        container.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        productImage.topAnchor.constraint(equalTo: container.topAnchor,constant: 8).isActive = true
        productImage.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 8).isActive = true
        productImage.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -8).isActive = true
        
        productTitle.topAnchor.constraint(equalTo: productImage.bottomAnchor,constant: 8).isActive = true
        productTitle.leadingAnchor.constraint(equalTo: productImage.leadingAnchor).isActive = true
        productTitle.trailingAnchor.constraint(equalTo: productImage.trailingAnchor).isActive = true
        
        productCategory.topAnchor.constraint(equalTo: productTitle.bottomAnchor,constant: 4).isActive = true
        productCategory.leadingAnchor.constraint(equalTo: productImage.leadingAnchor).isActive = true
        productCategory.trailingAnchor.constraint(equalTo: productImage.trailingAnchor).isActive = true
        
        productPrice.topAnchor.constraint(equalTo: productCategory.bottomAnchor,constant: 8).isActive = true
        productPrice.leadingAnchor.constraint(equalTo: productImage.leadingAnchor).isActive = true
        productPrice.trailingAnchor.constraint(equalTo: productImage.trailingAnchor).isActive = true
        productPrice.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -24).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
