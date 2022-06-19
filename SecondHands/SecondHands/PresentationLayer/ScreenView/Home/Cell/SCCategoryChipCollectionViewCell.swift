//
//  SCCategoryChipCollectionViewCell.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 16/06/22.
//

import UIKit

class SCCategoryChipCollectionViewCell: UICollectionViewCell {
    typealias onTap = () -> Void
    
    lazy var containerView: UIView = {
        var chip = UIView()
        chip.layer.cornerRadius = 12
        chip.backgroundColor = UIColor(red: 0.886, green: 0.831, blue: 0.941, alpha: 1)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:)))
        chip.addGestureRecognizer(tapGesture)
        chip.isUserInteractionEnabled = true
        return chip
    }()
    
    lazy var textTitle: UILabel = {
        var textTitle = UILabel()
        textTitle.text = "Keranjang Sepatu"
        textTitle.font = .systemFont(ofSize: 14, weight: .regular)
        textTitle.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        return textTitle
    }()
    
    lazy var iconView: UIImageView = {
        var iconView = UIImageView()
        iconView.image = UIImage(systemName: "magnifyingglass")
        iconView.tintColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        iconView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 14).isActive = true
        return iconView
    }()
    
    lazy var chipStackView: UIStackView = {
        var chipStackView = UIStackView(arrangedSubviews: [iconView, textTitle])
        chipStackView.axis = .horizontal
        chipStackView.spacing = 8
        
        return chipStackView
    }()
    
    var isClicked: Bool = false
    var onChipTap: onTap?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(containerView)
        containerView.addSubview(chipStackView)
        
        setupConstraint()
    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer) {
        print("Tapped")
        isClicked.toggle()
        
        button(state: isClicked)
        onChipTap?()
    }
    
    private func button(state: Bool) {
        if isClicked {
            containerView.backgroundColor = UIColor(red: 0.443, green: 0.149, blue: 0.71, alpha: 1)
            iconView.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            textTitle.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            containerView.backgroundColor = UIColor(red: 0.886, green: 0.831, blue: 0.941, alpha: 1)
            iconView.tintColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
            textTitle.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        }
    }
    
    private func setupConstraint() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        chipStackView.translatesAutoresizingMaskIntoConstraints = false
        
        chipStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14).isActive = true
        chipStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        chipStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16).isActive = true
        chipStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -14).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
