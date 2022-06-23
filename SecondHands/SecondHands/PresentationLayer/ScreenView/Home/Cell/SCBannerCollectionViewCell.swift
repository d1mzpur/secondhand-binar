//
//  BannerCollectionViewCell.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 17/06/22.
//

import UIKit

class SCBannerCollectionViewCell: UICollectionViewCell {
    var searchBar: SCSearchBar = {
        var searchBar = SCSearchBar()
        searchBar.layer.cornerRadius = 16
        searchBar.clipsToBounds = true
        searchBar.height = 48
        searchBar.margin = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16)
        searchBar.backgroundColor = .white
        
        
        return searchBar
    }()
    
    var offerImage: UIImageView = {
        var imageOffers = UIImageView()
        
        imageOffers.contentMode = .scaleAspectFit
        return imageOffers
    }()
    
    var offerTitle: UILabel = {
        var titleOffers = UILabel()
        titleOffers.font = SCLabel(frame: .zero, weight: .bold, size: 20).font
        titleOffers.textColor = .Neutral05
        titleOffers.numberOfLines = 0
        return titleOffers
    }()
    
    var subDiscount: UILabel = {
        var titleOffers = UILabel()
        let text: String = "Diskon Hingga"
        titleOffers.text = text
        titleOffers.font = SCLabel(frame: .zero, weight: .regular, size: 10).font
        titleOffers.textColor = .Neutral05
        return titleOffers
    }()
    
    var discount: UILabel = {
        var titleOffers = UILabel()
        titleOffers.font = SCLabel(frame: .zero, weight: .medium, size: 18).font
        titleOffers.textColor = .red
        return titleOffers
    }()
    
//    lazy var discountStackView: UIStackView = {
//        var discountSV = UIStackView(arrangedSubviews: [subDiscount, discount])
//        discountSV.axis = .vertical
//        discountSV.spacing = 4
//        return discountSV
//    }()
    
    lazy var titleStackView: UIStackView = {
        var titleSV = UIStackView(arrangedSubviews: [offerTitle, subDiscount, discount])
        titleSV.axis = .vertical
        titleSV.setCustomSpacing(16, after: offerTitle)
        titleSV.setCustomSpacing(4, after: subDiscount)
        titleSV.setCustomSpacing(16, after: discount)
        return titleSV
    }()
    
    lazy var bannerStackView: UIStackView = {
        var bannerSC = UIStackView(arrangedSubviews: [titleStackView, offerImage])
        bannerSC.axis = .horizontal
        
        return bannerSC
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(bannerStackView)
        self.addSubview(searchBar)
        setupConstraint()
    }
    
    func configure(item: OfferItem) {
        offerImage.image = UIImage(named: "offerImage")
        offerTitle.text = item.bannerTitle
        discount.text = item.discount
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraint() {
        bannerStackView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        offerImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            offerImage.heightAnchor.constraint(equalToConstant: 123),
            offerImage.widthAnchor.constraint(equalToConstant: 127),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            searchBar.bottomAnchor.constraint(equalTo: bannerStackView.topAnchor, constant: -16),
            
            bannerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            bannerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            bannerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
        ])
        
    }
}
