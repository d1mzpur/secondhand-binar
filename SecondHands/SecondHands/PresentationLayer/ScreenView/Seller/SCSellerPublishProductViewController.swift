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
        view.addSubview(makeHeaderImageView())
        makeHeaderImageView().bringSubviewToFront(stack)
        stack.setCustomSpacing(16, after: productCard)
        stack.setCustomSpacing(16, after: sellerCard)
        stack.axis = .vertical
        return stack
    }()
    
    private func makeHeaderImageView() -> UIImageView {
        let imageName = "exampleProductCardImage.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 0,y: 0,width: 360, height: 300)
        return imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(formStack)
        
        productCard.productImage.isHidden = true
        sellerCard.editButton.isHidden = true
        
        formStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            formStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 265),
            formStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            productCard.productStack.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 22),
            productCard.productStack.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            productCard.productStack.heightAnchor.constraint(equalTo: productCard.heightAnchor, constant: 0)
        ])
        
    }
    
    @objc
    func backButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
