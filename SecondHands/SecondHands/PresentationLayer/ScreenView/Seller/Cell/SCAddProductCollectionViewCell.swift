//
//  SCAddProductCollectionViewCell.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 27/06/22.
//

import UIKit

class SCAddProductCollectionViewCell: UICollectionViewCell {
    lazy var imagePicker = SCImagePicker(frame: .zero, style: .style2) { (image) in }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imagePicker)
        setupConstraint()
    }
    
    private func setupConstraint() {
        imagePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imagePicker.topAnchor.constraint(equalTo: contentView.topAnchor),
            imagePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imagePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
