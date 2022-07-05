//
//  SCSellerProductListViewController.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 27/06/22.
//

import UIKit

class SCSellerProductListViewController: UIViewController {
    var sellerView = SCSellerProfileView()
    var user: User = User.createData()
    var dataProduct: [ProductItem]?
    var selectedCategoryIndex: Int = -1
    
    var categoryCollection: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var sellerCollection: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
        view.addSubview(sellerView)
        view.addSubview(categoryCollection)
        view.addSubview(sellerCollection)
        setupCollection()
        setupConstraint()
    }
    
    private func setupCollection() {
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        sellerCollection.delegate = self
        sellerCollection.dataSource = self
        
        categoryCollection.register(SCCategoryChipCollectionViewCell.self, forCellWithReuseIdentifier: "sellerCategory")
        sellerCollection.register(SCAddProductCollectionViewCell.self, forCellWithReuseIdentifier: "addProdcut")
        sellerCollection.register(SCProductCardViewCollectionViewCell.self, forCellWithReuseIdentifier: "sellerProduct")
    }
    
    private func configureView() {
        categoryCollection.collectionViewLayout = LayoutSection.createLayoutCategory()
        sellerCollection.collectionViewLayout = LayoutSection.createSellerProduct()
        
        categoryCollection.backgroundColor = .white
        
        sellerCollection.backgroundColor = .white
        sellerCollection.showsVerticalScrollIndicator = false
        
        sellerView.configure(user: user)
        
//        sellerView.configure(user: user)
    }
    
    private func setupConstraint() {
        sellerView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollection.translatesAutoresizingMaskIntoConstraints = false
        sellerCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sellerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            sellerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sellerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            categoryCollection.topAnchor.constraint(equalTo: sellerView.bottomAnchor, constant: 16),
            categoryCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            sellerCollection.topAnchor.constraint(equalTo: categoryCollection.bottomAnchor, constant: 16),
            sellerCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sellerCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sellerCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension SCSellerProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProduct?.count ?? 0 + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let addProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addProdcut", for: indexPath) as? SCAddProductCollectionViewCell,
              let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sellerProduct", for: indexPath) as? SCProductCardViewCollectionViewCell
        else { return UICollectionViewCell() }
        
        let item = indexPath.item
        let data = (self.dataProduct?[item > 0 ? item - 1 : item] ?? nil)
        if item == 0 {
            return addProductCell
        } else {
            productCell.configure(item: data!)
            return productCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let _ = collectionView.cellForItem(at: indexPath) as? SCProductCardViewCollectionViewCell else { return }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sellerHeader", for: indexPath) as? CategoryCollectionReusableView
        else { return UICollectionReusableView() }
        cell.configure(product: dataProduct ?? [])
        return cell
    }
}
