//
//  SCChipView.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 18/06/22.
//

import UIKit

class SCChipView: UIView {
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
    
    typealias onTap = () -> Void
    
    var viewOnTap: onTap?
    var isClicked: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeContainerView(defaultContainerView: .DarkBlue01, action: #selector(onTapGesute(state:)))
        self.addSubview(chipStackView)
       
        setupConstraint()
    }
    
    @objc
    private func onTapGesute(state: Bool) {
        viewOnTap?()
        if isClicked {
            self.backgroundColor = .DarkBlue04
            iconView.tintColor = .Neutral01
            textTitle.textColor = .Neutral01
        } else {
            self.backgroundColor = .DarkBlue01
            iconView.tintColor = .Neutral04
            textTitle.textColor = .Neutral04
        }
    }
    
    private func setupConstraint() {
        chipStackView.translatesAutoresizingMaskIntoConstraints = false
        
        chipStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14).isActive = true
        chipStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        chipStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        chipStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14).isActive = true
    }
    
    private func makeContainerView(defaultContainerView: UIColor? = nil, action: Selector) {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        view.backgroundColor = defaultContainerView
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
