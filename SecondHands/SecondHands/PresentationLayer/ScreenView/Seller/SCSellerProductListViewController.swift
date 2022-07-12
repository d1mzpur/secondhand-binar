//
//  SCSellerProductListViewController.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 27/06/22.
//

import UIKit

enum SellerCategory: String, CaseIterable {
    case product = "Produk"
    case diminati = "Diminati"
    case terjual = "Terjual"
}

class SCSellerProductListViewController: UIViewController {
    var sellerView = SCSellerProfileView()
    var user: User = User.createData()
    var dataProduct: [ProductItem]?
    var selectedCategoryIndex: Int = -1
    
    let service = NetworkServices()
    
    var sellerCollection: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollection()
        configureView()
        
        view.addSubview(sellerView)
        view.addSubview(sellerCollection)
        getData()
        setupConstraint()
    }
    
    func getData() {
        service.getProduct(by: .buyer) { (result) in
            switch result {
            case .success(let product):
                print(product)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupCollection() {
        sellerCollection.delegate = self
        sellerCollection.dataSource = self

        sellerCollection.register(SCCategoryChipCollectionViewCell.self, forCellWithReuseIdentifier: "sellerCategory")
        sellerCollection.register(SCAddProductCollectionViewCell.self, forCellWithReuseIdentifier: "addProduct")
        sellerCollection.register(SCProductCardViewCollectionViewCell.self, forCellWithReuseIdentifier: "sellerProduct")
    }
    
    private func configureView() {
        sellerCollection.collectionViewLayout = LayoutSection.createSellerProduct()

        sellerCollection.backgroundColor = .white
        sellerCollection.showsVerticalScrollIndicator = false

        sellerView.configure(user: user)
    }
    
    private func setupConstraint() {
        sellerView.translatesAutoresizingMaskIntoConstraints = false
        sellerCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sellerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            sellerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sellerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//
            sellerCollection.topAnchor.constraint(equalTo: sellerView.bottomAnchor, constant: 24),
            sellerCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sellerCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sellerCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension SCSellerProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return SellerCategory.allCases.count
        } else {
            return dataProduct?.count ?? 0 + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sellerCategory", for: indexPath) as? SCCategoryChipCollectionViewCell,
            let addProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addProduct", for: indexPath) as? SCAddProductCollectionViewCell,
              let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sellerProduct", for: indexPath) as? SCProductCardViewCollectionViewCell
        else { return UICollectionViewCell() }

        let item = indexPath.item
        let data = (self.dataProduct?[item > 0 ? item - 1 : item] ?? nil)
        
        if indexPath.section == 0 {
            categoryCell.configure(item: SellerCategory.allCases[indexPath.item].rawValue)
            return categoryCell
        } else {
            if item == 0 {
                return addProductCell
            } else {
                productCell.configure(item: data!)
                return productCell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let _ = collectionView.cellForItem(at: indexPath) as? SCProductCardViewCollectionViewCell else { return }
    }
    
}
