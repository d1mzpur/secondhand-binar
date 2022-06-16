//
//  SCProductCard.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 6/16/22.
//

import UIKit

class SCProductCard: UIView {
    lazy var productImage: UIImageView = {
        let imageName = "exampleProductCardImage.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var productTitle: SCLabel = {
        var lbl = SCLabel()
        lbl.text = "Jam Tangan Casio"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var productCategory: SCLabel = {
        var lbl = SCLabel()
        lbl.text = "Aksesoris"
        lbl.size = 10
        lbl.textColor = .systemGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var productPrice: SCLabel = {
        var lbl = SCLabel()
        lbl.text = "Rp 250.000"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var productStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            productImage,
            productTitle,
            productCategory,
            productPrice,
            UIView()
        ])
        stackView.setCustomSpacing(8.0, after: productImage)
        stackView.setCustomSpacing(4.0, after: productTitle)
        stackView.setCustomSpacing(8.0, after: productCategory)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        setup()
    }
    
    init(frame: CGRect = CGRect.zero, productImageURL: String, productTitle: String, productCategory: String, productPrice: String) {
        super.init(frame: frame)
        self.productImage.loadImage(resource: productImageURL)
        self.productTitle.text = productTitle
        self.productCategory.text = productCategory
        self.productPrice.text = productPrice
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // This will call `awakeFromNib` in your code
        setup()
    }
    
    private func setup() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.dropShadow(type: .low)
        self.addSubview(productStack)

        NSLayoutConstraint.activate([
    
            productStack.topAnchor.constraint(equalTo: self.topAnchor,constant: 8),
            productStack.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 8),
            productStack.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -8),
            productStack.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -8),
            
            productImage.heightAnchor.constraint(equalTo: productStack.heightAnchor, multiplier: 0.5),
            productTitle.heightAnchor.constraint(equalTo: productStack.heightAnchor, multiplier: 0.1),
            productCategory.heightAnchor.constraint(equalTo: productStack.heightAnchor, multiplier: 0.075),
            productPrice.heightAnchor.constraint(equalTo: productStack.heightAnchor, multiplier: 0.1),
        ])
        
    }
}
