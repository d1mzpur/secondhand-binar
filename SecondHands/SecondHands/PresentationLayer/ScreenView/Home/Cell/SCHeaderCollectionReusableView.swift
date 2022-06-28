//
//  SCHeaderCollectionReusableView.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 27/06/22.
//

import UIKit

class SCHeaderCollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = "categorySection"
    lazy var label = UILabel()
    var margin = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            updateMarginConstraint()
        }
    }
    
    var topConstraint: NSLayoutConstraint!
    var leadingConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.frame = bounds
        addSubview(label)
        setupconstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateMarginConstraint() {
        topConstraint.constant = margin.top
        bottomConstraint.constant = margin.bottom
        leadingConstraint.constant = margin.left
        trailingConstraint.constant = margin.right
    }
    
    private func setupconstraint() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        topConstraint = label.topAnchor.constraint(equalTo: self.topAnchor)
        leadingConstraint = label.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        bottomConstraint = label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        trailingConstraint = label.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        bottomConstraint.isActive = true
        trailingConstraint.isActive = true
    }
}
