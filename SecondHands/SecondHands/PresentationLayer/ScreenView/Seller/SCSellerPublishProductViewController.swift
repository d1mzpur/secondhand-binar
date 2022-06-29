//
//  SCSellerPublishProductViewController.swift
//  SecondHands
//
//  Created by Dimas Purnomo on 29/06/22.
//

import UIKit

class SCSellerPublishProductViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.barTintColor = .white
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.black
        let image = UIImage(systemName: "arrow.left")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButton))
    }
    
    lazy var productCard = SCProductCard(frame: .zero, productImageURL: "", productTitle: "Jam Tangan Casio", productCategory: "Aksesoris", productPrice: "Rp 250.000")
    
    lazy var sellerCard = SCSellerProfileView(frame: .zero, productImageURL: "", productLabel: "Nama Penjual", sellerCity: "Kota")
    
    lazy var descCard = SCDescCard(frame: .zero, descLabel: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
    
    lazy var formStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [
        productCard,
        sellerCard,
        descCard,
       ])
        stack.setCustomSpacing(16, after: productCard)
        stack.setCustomSpacing(16, after: sellerCard)
        stack.axis = .vertical
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(formStack)
        
        formStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            formStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 106),
            formStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
        
    }
    
    @objc
    func backButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
