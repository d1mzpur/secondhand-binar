//
//  SCBuyerModalCard.swift
//  SecondHands
//
//  Created by Tatang Sulaeman on 20/07/22.
//

import UIKit

class SCBuyerModalCard: UIView {
    
    var imageProduct: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        
        return image
    }()
    
    var productName: SCLabel = {
        var productName = SCLabel(frame: .zero, weight: .medium, size: 14)
        productName.textColor = .Neutral05
        
        return productName
    }()
    
    var productPrice: SCLabel = {
        var productPrice = SCLabel(frame: .zero, weight: .regular, size: 14)
        productPrice.textColor = .Neutral03
        
        return productPrice
    }()
    
    lazy var labelStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            productName,
            productPrice
        ])
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    override init(frame: CGRect =  CGRect.zero) {
        super.init(frame: frame)
        addSubview()
        setupConstraint()
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
    }
    
    init(frame: CGRect, imageProduct: String, productName: String, productPrice: String) {
        super.init(frame: frame)
        self.imageProduct.loadImage(resource: imageProduct)
        self.productName.text = productName
        self.productPrice.text = productPrice
        addSubview()
        setupConstraint()
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.dropShadow(type: .low)
    }
    
    func addSubview(){
        self.addSubview(imageProduct)
        self.addSubview(labelStack)
    }
    
    func setupConstraint(){
        imageProduct.translatesAutoresizingMaskIntoConstraints = false
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageProduct.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            imageProduct.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            imageProduct.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            imageProduct.heightAnchor.constraint(equalToConstant: 48),
            imageProduct.widthAnchor.constraint(equalToConstant: 48),
            
            labelStack.topAnchor.constraint(equalTo: imageProduct.topAnchor, constant: 5),
            labelStack.leadingAnchor.constraint(equalTo: imageProduct.trailingAnchor, constant: 16),
            labelStack.bottomAnchor.constraint(equalTo: imageProduct.bottomAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
