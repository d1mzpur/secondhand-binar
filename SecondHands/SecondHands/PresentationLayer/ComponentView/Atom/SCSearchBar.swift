//
//  SCSearchBar.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 20/06/22.
//

import UIKit

class SCSearchBar: UIView {
    var searchBar: UITextField = {
       var searchBar = UITextField()
        searchBar.placeholder = "Cari di Second Hand"
        searchBar.font = SCLabel(frame: .zero, weight: .regular, size: 14).font
        searchBar.tintColor = .Neutral03
        searchBar.textColor = .black
        return searchBar
    }()
    
    var iconTap: UIImageView = {
        var iconTap = UIImageView()
        iconTap.contentMode = .scaleAspectFit
        iconTap.heightAnchor.constraint(equalToConstant: 16).isActive = true
        return iconTap
    }()
    
    lazy var searchStackView: UIStackView = {
        var searchStackView = UIStackView(arrangedSubviews: [searchBar, iconTap])
        searchStackView.axis = .horizontal
        searchStackView.distribution = .fillProportionally
        return searchStackView
    }()
    
    private var heightConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?
    
    private var topConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!
    
    var height: CGFloat? {
        didSet { updateHeightConstraint() }
    }
    
    var width: CGFloat? {
        didSet { updateWidthConstraint() }
    }
    
    var margin = UIEdgeInsets(top: 4, left: 8, bottom: -4, right: -8) {
        didSet { updateMarginConstraint() }
    }
    
    var searchText: String? {
        didSet {
            searchText = searchBar.text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .black
        
        setupAddSubview()
        setupConstraint()
    }
    
    
    
    private func setupAddSubview() {
        self.addSubview(searchBar)
    }
    
    func configure(placeHolder: String) {
        searchBar.placeholder = placeHolder
    }
    
    private func updateHeightConstraint() {
        guard let height = height else {
            return
        }
        if heightConstraint == nil {
            heightConstraint = searchBar.heightAnchor.constraint(greaterThanOrEqualToConstant: height)
            heightConstraint?.isActive = true
        } else {
            heightConstraint?.constant = height
        }
    }
    
    private func updateWidthConstraint() {
        guard let width = width else {
            return
        }
        if widthConstraint == nil {
            widthConstraint = searchBar.widthAnchor.constraint(equalToConstant: width)
            widthConstraint?.isActive = true
        } else {
            widthConstraint?.constant = width
        }
    }
    
    private func setupConstraint() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        topConstraint = searchBar.topAnchor.constraint(equalTo: self.topAnchor)
        bottomConstraint = searchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        leadingConstraint = searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        trailingConstraint = searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        
        topConstraint.isActive = true
        bottomConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    func updateMarginConstraint() {
        topConstraint.constant = margin.top
        bottomConstraint.constant = margin.bottom
        leadingConstraint.constant = margin.left
        trailingConstraint.constant = margin.right
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
