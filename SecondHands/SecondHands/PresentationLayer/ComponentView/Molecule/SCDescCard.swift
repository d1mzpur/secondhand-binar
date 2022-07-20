//
//  SCDescCard.swift
//  SecondHands
//
//  Created by Dimas Purnomo on 29/06/22.
//

import UIKit

class SCDescCard: UIView {
    lazy var descTitle: SCLabel = {
        var lbl = SCLabel()
        lbl.text = "Deskripsi"
        lbl.textColor = .Neutral05
        lbl.weight = .medium
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var descLabel: SCLabel = {
        var lbl = SCLabel()
        lbl.text = "Note Deskripsi"
        lbl.textColor = .Neutral03
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = true
        return lbl
    }()
    
    lazy var productStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            descTitle,
            descLabel,
            UIView()
        ])
        stackView.setCustomSpacing(16.0, after: descTitle)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        setup()
    }
    
    init(frame: CGRect = CGRect.zero, descLabel: String) {
        super.init(frame: frame)
        self.descLabel.text = descLabel
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // This will call `awakeFromNib` in your code
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.dropShadow(type: .low)
    }
    
    
    private func setup() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.addSubview(productStack)
        
        productStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
    
            productStack.topAnchor.constraint(equalTo: self.topAnchor,constant: 19),
            productStack.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16),
            productStack.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -16),
            productStack.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -16),
            
//            productImage.heightAnchor.constraint(equalTo: productImage.widthAnchor, multiplier: 0.71),
//            productTitle.heightAnchor.constraint(equalTo: productStack.heightAnchor, multiplier: 0.1),
//            productCategory.heightAnchor.constraint(equalTo: productStack.heightAnchor, multiplier: 0.075),
//            productPrice.heightAnchor.constraint(equalTo: productStack.heightAnchor, multiplier: 0.1),
        ])
        
    }
}

