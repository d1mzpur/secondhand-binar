//
//  SCSellerViewController.swift
//  SecondHands
//
//  Created by Dimas Purnomo on 28/06/22.
//

import UIKit


class SCSellerViewController: UIViewController {
    
    lazy var itemList : SCSellerItem = SCSellerItem (productImageURL: "String", productLabel: "Penawaran produk", productTitle: "Jam Tangan Casio", productPrice: "Rp 250.000", discountProduct: "Ditawar Rp 200.000")
    
    lazy var textTitle: UILabel = {
        var textTitle = UILabel()
        textTitle.text = "Daftar Jual Saya"
        textTitle.font = SCLabel(frame: .zero, weight: .bold, size: 20).font
        textTitle.textColor = .black
        return textTitle
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(textTitle)
        view.addSubview(itemList)
        
        itemList.translatesAutoresizingMaskIntoConstraints = false
        textTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            textTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -16),
            textTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        
            itemList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            itemList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            itemList.topAnchor.constraint(equalTo: textTitle.topAnchor, constant: 24),
            
        ])
        
    }
    
   
}
