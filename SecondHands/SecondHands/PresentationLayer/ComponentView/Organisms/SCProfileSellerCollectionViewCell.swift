//
//  SCProfileSellerCollectionViewCell.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 27/06/22.
//

import UIKit

class SCProfileSellerCollectionViewCell: UICollectionViewCell {
    var imageSeller: UIImageView = {
        var imageSeller = UIImageView()
        imageSeller.contentMode = .scaleAspectFill
        imageSeller.layer.cornerRadius = 12
        imageSeller.clipsToBounds = true
        
        return imageSeller
    }()
    
    var usernameSeller: SCLabel = {
        var usernameSeller = SCLabel(frame: .zero, weight: .medium, size: 14)
        usernameSeller.textColor = .Neutral05
        
        return usernameSeller
    }()
    
    var sellerCity: SCLabel = {
        var usernameSeller = SCLabel(frame: .zero, weight: .regular, size: 10)
        usernameSeller.textColor = .Neutral03
        
        return usernameSeller
    }()
    
    lazy var labelStackView: UIStackView = {
        var labelStackView = UIStackView(arrangedSubviews: [usernameSeller, sellerCity])
        labelStackView.axis = .vertical
        labelStackView.spacing = 4
        return labelStackView
    }()
    
    var editButton: UIButton = {
        var editButton = UIButton()
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.Neutral04, for: .normal)
        editButton.titleLabel?.font = SCLabel(frame: .zero, weight: .medium, size: 12).font
        editButton.backgroundColor = .white
        editButton.clipsToBounds = true
        editButton.layer.cornerRadius = 8
        editButton.layer.borderWidth = 1
        editButton.layer.borderColor = UIColor.DarkBlue04.cgColor
        
        return editButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupConstraint()
        self.contentView.layer.cornerRadius = 16
        self.contentView.clipsToBounds = true
        self.contentView.dropShadow(type: .low)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageSeller.image = nil
        usernameSeller.text = nil
        sellerCity.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func addSubview() {
        contentView.addSubview(imageSeller)
        contentView.addSubview(labelStackView)
        contentView.addSubview(editButton)
        
        contentView.backgroundColor = .white
    }
    
    func configure(user: User) {
        imageSeller.image = UIImage(named: user.imageUser)
        usernameSeller.text = user.userName
        sellerCity.text = user.city
    }
    
    private func setupConstraint() {
        imageSeller.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageSeller.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            imageSeller.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            imageSeller.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            imageSeller.heightAnchor.constraint(equalToConstant: 48),
            imageSeller.widthAnchor.constraint(equalToConstant: 48),
            
            labelStackView.topAnchor.constraint(equalTo: imageSeller.topAnchor, constant: 5),
            labelStackView.leadingAnchor.constraint(equalTo: imageSeller.trailingAnchor, constant: 16),
            labelStackView.bottomAnchor.constraint(equalTo: imageSeller.bottomAnchor, constant: -5),
            
            editButton.topAnchor.constraint(equalTo: imageSeller.topAnchor, constant: 11),
            editButton.leadingAnchor.constraint(equalTo: labelStackView.trailingAnchor, constant: 16),
            editButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            editButton.bottomAnchor.constraint(equalTo: imageSeller.bottomAnchor, constant: -11),
            editButton.heightAnchor.constraint(equalToConstant: 26),
            editButton.widthAnchor.constraint(equalToConstant: 47),
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
