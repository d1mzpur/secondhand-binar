//
//  SCSellerProductListViewController2.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 6/30/22.
//

import UIKit

class SCSellerProductListViewController: UIViewController {
    var sellerView = SCSellerProfileView()
    var user: User = User.createData()
    var dataProduct: [ProductItem] = []
    var categoryTitleArray: [String] = ["Produk","Diminati","Terjual"]
    
    
    var selectedCategory: String = "Produk"
    lazy var textTitle: UILabel = {
        var textTitle = UILabel()
        textTitle.text = "Daftar Jual Saya"
        textTitle.font = SCLabel(frame: .zero, weight: .bold, size: 20).font
        textTitle.textColor = .black
        return textTitle
    }()
    
    lazy var sellerCategory: SCSellerCategoryCollectionView = SCSellerCategoryCollectionView(viewController: self, categoryTitleArray: categoryTitleArray)
    lazy var sellerCollection: SCSellerProductCollectionView = SCSellerProductCollectionView(dataProduct: dataProduct)
    lazy var sellerTableView: SCSellerProductTableView = SCSellerProductTableView(dataProduct: dataProduct)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
        view.addSubview(textTitle)
        view.addSubview(sellerView)
        view.addSubview(sellerCategory)
  
        sellerCollection.removeFromSuperview()
        sellerTableView.removeFromSuperview()
        switch( selectedCategory ){
        case "Produk":
            view.addSubview(sellerCollection)
            setupCollection()
            break;
        case "Diminati":
            view.addSubview(sellerTableView)
            setupTableView()
            break;
        case "Terjual":
            break;
        default:
            break;
        }
        setupConstraint()
    }

    
    private func configureView() {
        sellerView.configure(user: user)
    }
    
    private func setupCollection() {
        NSLayoutConstraint.activate([
            sellerCollection.topAnchor.constraint(equalTo: sellerCategory.bottomAnchor, constant: 8),
            sellerCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sellerCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sellerCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupTableView() {
        NSLayoutConstraint.activate([
            sellerTableView.topAnchor.constraint(equalTo: sellerCategory.bottomAnchor, constant: 8),
            sellerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sellerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sellerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupConstraint() {
        textTitle.translatesAutoresizingMaskIntoConstraints = false
        sellerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            sellerView.topAnchor.constraint(equalTo: textTitle.bottomAnchor, constant: 16),
            sellerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sellerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            sellerCategory.topAnchor.constraint(equalTo: sellerView.bottomAnchor, constant: 8),
            sellerCategory.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sellerCategory.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sellerCategory.heightAnchor.constraint(equalToConstant: 60),
    
        ])
    }
}

