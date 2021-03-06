//
//  SCSellerItem.swift
//  SecondHands
//
//  Created by Dimas Purnomo on 27/06/22.
//

import UIKit

class SCSellerItem: UIView {
    var bottomConstrain = NSLayoutConstraint()
    
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
        lbl.textColor = .Neutral03
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
    
    lazy var productOfferPrice: SCLabel = {
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
    
    lazy var actionButton1: SCButton = SCButton(style: .secondary, size: .small, type: .defaultButton, title: "Tolak")
    
    lazy var actionButton2: SCButton = SCButton(style: .primary, size: .small, type: .defaultButton, title: "Terima")
    
    lazy var productStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            productLabel,
            productTitle,
            productPrice,
            productOfferPrice,
            UIView()
        ])
        stackView.setCustomSpacing(4.0, after: productLabel)
        stackView.setCustomSpacing(4.0, after: productTitle)
        stackView.setCustomSpacing(4.0, after: productPrice)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            actionButton1,
            actionButton2,
        ])
        stackView.spacing = 10
        stackView.distribution  = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        setup()
    }
    
    
    init(frame: CGRect = CGRect.zero, productImageURL: String, productLabel: String, productTitle: String, productPrice: String, productOfferPrice: String) {
        super.init(frame: frame)
        self.productImage.loadImage(resource: productImageURL)
        self.productLabel.text = productLabel
        self.productTitle.text = productTitle
        self.productPrice.text = productPrice
        self.productOfferPrice.text = productOfferPrice
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func addbutton(button1Name:String, button2Name:String){
        actionButton1.setTitle(button1Name, for: .normal)
        actionButton2.setTitle(button2Name, for: .normal)
        bottomConstrain.isActive = false
        self.addSubview(buttonStack)
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: productStack.bottomAnchor, constant: 16),
            buttonStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
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
            
            timeProduct.topAnchor.constraint(equalTo: self.topAnchor),
            timeProduct.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            productStack.topAnchor.constraint(equalTo: self.topAnchor),
            productStack.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 60),
            productStack.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 10),
            
        ])
        bottomConstrain = productStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        bottomConstrain.isActive = true
        
    }

    
}
