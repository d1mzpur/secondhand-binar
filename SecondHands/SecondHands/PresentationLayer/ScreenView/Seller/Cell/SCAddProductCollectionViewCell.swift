//
//  SCAddProductCollectionViewCell.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 27/06/22.
//

import UIKit

class SCAddProductCollectionViewCell: UICollectionViewCell {
    lazy var addLabel: SCLabel = {
        var lbl = SCLabel( weight: .regular, size: 12)
        lbl.text = "Tambah Produk"
        lbl.textColor = .Neutral04
        return lbl
    }()
    lazy var pickerIcon: UIImageView = {
        let image = UIImage(systemName: "plus")
        let imageView = UIImageView(image: image!)
        imageView.tintColor = .Neutral03
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var container: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 10
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(container)
        container.addSubview(pickerIcon)
        container.addSubview(addLabel)
        setupConstraint()
    }
    
    override func layoutSubviews() {
        container.addDashedBorder()
    }
    
    
    private func setupConstraint() {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.heightAnchor.constraint(equalToConstant: 247).isActive = true
        container.widthAnchor.constraint(equalToConstant: 156 * 1.2).isActive = true
        
        pickerIcon.translatesAutoresizingMaskIntoConstraints = false
        pickerIcon.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        pickerIcon.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -5).isActive = true
        pickerIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        pickerIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        addLabel.translatesAutoresizingMaskIntoConstraints = false
        addLabel.topAnchor.constraint(equalTo: pickerIcon.bottomAnchor, constant: 10).isActive = true
        addLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
