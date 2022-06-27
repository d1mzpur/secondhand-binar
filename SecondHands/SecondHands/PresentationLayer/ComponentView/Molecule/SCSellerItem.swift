//
//  SCSellerItem.swift
//  SecondHands
//
//  Created by Dimas Purnomo on 27/06/22.
//

import UIKit

class SCSellerItem: UIView {
    
    lazy var productImage: UIImageView = {
        let imageName = "exampleProductCardImage.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.autoresizingMask = [.flexibleWidth]
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var productLabel: SCLabel = {
        var lbl = SCLabel()
        lbl.text = "Penawaran produk"
        lbl.textColor = .Neutral02
        lbl.size = 10
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var productTitle: SCLabel = {
        var lbl = SCLabel()
        lbl.text = "Jam Tangan Casio"
        lbl.textColor = .Neutral05
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.size = 14
        return lbl
    }()
    
    lazy var productPrice: SCLabel = {
        var lbl = SCLabel()
        lbl.text = "Rp 250.000"
        lbl.textColor = .Neutral05
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.size = 14
        return lbl
    }()
    
    lazy var discountProduct: SCLabel = {
        var lbl = SCLabel()
        lbl.text = "Ditawar Rp 200.000"
        lbl.textColor = .Neutral05
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.size = 14
        return lbl
    }()
    
    lazy var timeProduct: SCLabel = {
        var lbl = SCLabel()
        lbl.text = "20 Apr, 14:04"
        lbl.textColor = .Neutral02
        lbl.size = 10
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var productStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            productLabel,
            productTitle,
            productPrice,
            discountProduct,
            UIView()
        ])
        stackView.setCustomSpacing(4.0, after: productLabel)
        stackView.setCustomSpacing(4.0, after: productTitle)
        stackView.setCustomSpacing(4.0, after: productPrice)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        setup()
    }
    
    init(frame: CGRect = CGRect.zero, productImageURL: String, productLabel: String, productTitle: String, productPrice: String, discountProduct: String ) {
        super.init(frame: frame)
        self.productImage.loadImage(resource: productImageURL)
        self.productLabel.text = productLabel
        self.productTitle.text = productTitle
        self.productPrice.text = productPrice
        self.discountProduct.text = discountProduct
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 40
        self.addSubview(productImage)
        self.addSubview(productStack)
        self.addSubview(timeProduct)
        
        productImage.clipsToBounds = true
        productImage.contentMode = .scaleAspectFill
        productImage.layer.cornerRadius = 12
        
        
        
        
        
        NSLayoutConstraint.activate([
                
            productImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            productImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 48),
            productImage.widthAnchor.constraint(equalTo: productImage.heightAnchor),
            
            productStack.topAnchor.constraint(equalTo: productImage.topAnchor),
            productStack.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 60),
            productStack.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 10),
            
            timeProduct.topAnchor.constraint(equalTo: productImage.topAnchor),
            timeProduct.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            
        ])
        
    }

    
}
