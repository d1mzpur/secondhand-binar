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
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.dismiss(animated: true, completion: nil)
        self.tabBarController?.tabBar.isHidden = false
    }

    var productPrice: Int = 0 {
        didSet{
            self.productCard.productPrice.text = ("Rp \(productPrice)")
        }
    }
    
    var productCategoryId: Int = 0
    
    lazy var productCard = SCProductCard(frame: .zero, productImageURL: "", productTitle: "Jam Tangan Casio", productCategory: "Aksesoris", productPrice: "Rp 250.000")
    
    lazy var sellerCard = SCSellerProfileView(frame: .zero, productImageURL: "", productLabel: "Nama Penjual", sellerCity: "Kota")
    
    lazy var descCard = SCDescCard(frame: .zero, descLabel: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
    
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
    
    lazy var makeHeaderImageView: UIImageView = {
        let imageName = "exampleProductCardImage.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var publishButton: SCButton = SCButton(style: .primary, size: .normal, type: .defaultButton, title: "Terbitkan")
    
    func getUser() {
        NetworkServices().getUserAlamofire() { (result) in
            DispatchQueue.main.async {
                let user = User(
                    imageUser: result.image ?? "",
                    userName: result.fullName ?? "",
                    city: result.city ?? ""
                )
                self.sellerCard.configure(user: user)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        publishButton.addTarget(self, action: #selector(publishProduct), for: .touchUpInside )
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        var scrollView: UIScrollView!
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(formStack)
        scrollView.addSubview(makeHeaderImageView)
        scrollView.bringSubviewToFront(formStack)
        formStack.bringSubviewToFront(makeHeaderImageView)
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight)
        makeHeaderImageView.contentMode = .scaleToFill
        makeHeaderImageView.isUserInteractionEnabled = false
        
        scrollView.addSubview(publishButton)
        formStack.bringSubviewToFront(publishButton)
        
        productCard.productImage.isHidden = true
        sellerCard.editButton.isHidden = true
        
        formStack.translatesAutoresizingMaskIntoConstraints = false
        publishButton.translatesAutoresizingMaskIntoConstraints = false
        makeHeaderImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            makeHeaderImageView.topAnchor.constraint(equalTo: view.topAnchor),
            makeHeaderImageView.widthAnchor.constraint(equalToConstant: screenWidth),
            makeHeaderImageView.heightAnchor.constraint(equalToConstant: 300),
            
            formStack.topAnchor.constraint(equalTo: makeHeaderImageView.bottomAnchor, constant: -30),
            formStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            

            productCard.productStack.leadingAnchor.constraint(equalTo: formStack.leadingAnchor, constant: 22),
            productCard.productStack.trailingAnchor.constraint(equalTo: formStack.trailingAnchor, constant: -20),
            productCard.productStack.heightAnchor.constraint(equalTo: productCard.heightAnchor, constant: 0),
            
            publishButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            publishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            publishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            publishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    @objc func backButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func publishProduct() {
        NetworkServices().createProduct(
            name: self.productCard.productTitle.text ?? "",
            description: self.descCard.descLabel.text ?? "",
            price: productPrice ?? 0,
            category: self.productCategoryId ?? 0,
            location: self.sellerCard.sellerCity.text ?? "",
            image: (self.makeHeaderImageView.image?.jpegData(compressionQuality: 0.3))!
        ){ (result) in
            switch result {
            case .success(let success):
                print(success)
                self.tabBarController?.selectedIndex = 3
                self.navigationController?.popViewController(animated: false)
            case .failure(let error):
//                let alert = UIAlertController(title: "Pemberitahuan", message: "Gagal membuat product", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                self.present(alert, animated: true)
                print(error)
                return
            }
  
        }
    }
}
