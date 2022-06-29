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
        addSubview(imagePicker)
        setupConstraint()
    }
    
    private func setupConstraint() {
        imagePicker.translatesAutoresizingMaskIntoConstraints = false
        imagePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imagePicker.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imagePicker.heightAnchor.constraint(equalToConstant: 247).isActive = true
        imagePicker.widthAnchor.constraint(equalToConstant: 156 * 1.2).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
