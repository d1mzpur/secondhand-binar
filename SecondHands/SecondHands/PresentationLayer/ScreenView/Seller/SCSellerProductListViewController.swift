//
//  SCSellerProductListViewController.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 27/06/22.
//

import UIKit

class SCSellerProductListViewController: UIViewController {
    var sellerCollection: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    var user: User = User.createData()
    var dataProduct: [ProductItem] = ProductItem.createData()
    var selectedCategoryIndex: Int = -1
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        view.addSubview(sellerCollection)
        setupCollection()
        setupConstraint()
    }
    
    private func setupCollection() {
        sellerCollection.delegate = self
        sellerCollection.dataSource = self
        sellerCollection.register(SCProfileSellerCollectionViewCell.self, forCellWithReuseIdentifier: "sellerProfile")
        sellerCollection.register(SCCategoryChipCollectionViewCell.self, forCellWithReuseIdentifier: "sellerCategory")
        sellerCollection.register(SCAddProductCollectionViewCell.self, forCellWithReuseIdentifier: "addProdcut")
        sellerCollection.register(SCProductCardViewCollectionViewCell.self, forCellWithReuseIdentifier: "sellerProduct")
        sellerCollection.register(SCHeaderCollectionReusableView.self, forSupplementaryViewOfKind: "headerProductId", withReuseIdentifier: "headerSeller")
    }
    
    private func configureView() {
        sellerCollection.collectionViewLayout = LayoutSection.createSellerProduct()
        sellerCollection.backgroundColor = .white
        sellerCollection.showsVerticalScrollIndicator = false
    }
    
    private func setupConstraint() {
        sellerCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sellerCollection.topAnchor.constraint(equalTo: view.topAnchor),
            sellerCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sellerCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sellerCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension SCSellerProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 10
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let userProfile = collectionView.dequeueReusableCell(withReuseIdentifier: "sellerProfile", for: indexPath) as? SCProfileSellerCollectionViewCell,
              let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sellerCategory", for: indexPath) as? SCCategoryChipCollectionViewCell,
              let addProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addProdcut", for: indexPath) as? SCAddProductCollectionViewCell,
              let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sellerProduct", for: indexPath) as? SCProductCardViewCollectionViewCell
        else { return UICollectionViewCell() }
        
        let section = indexPath.section
        let item = indexPath.item
        let data = self.dataProduct[indexPath.item]
        
        if section == 0 {
            userProfile.configure(user: user)
            
            return userProfile
        } else if section == 1 {
            let selected = selectedCategoryIndex == indexPath[1]
            categoryCell.cellClicked(state: selected)
            categoryCell.configure(item: data.productCategory)
            
            return categoryCell
        } else {
            if item == 0 {
                return addProductCell
            } else {
                productCell.configure(item: data)
                return productCell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let _ = collectionView.cellForItem(at: indexPath) as? SCBannerCollectionViewCell else { return }
        case 1:
            let categoryCell = collectionView.cellForItem(at: indexPath) as?
                SCCategoryChipCollectionViewCell
            categoryCell?.onCellTapByIndex?(indexPath)
            
            if ((collectionView.dequeueReusableCell(withReuseIdentifier: "sellerCategory", for: indexPath) as? SCCategoryChipCollectionViewCell) != nil) {
                selectedCategoryIndex = selectedCategoryIndex != indexPath[1] ? indexPath[1] : -1
                print("Tap ", selectedCategoryIndex)
                collectionView.reloadData()
            }
            
        case 2:
            guard let _ = collectionView.cellForItem(at: indexPath) as? SCProductCardViewCollectionViewCell else { return }
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            let headerSeller = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerSeller", for: indexPath) as? SCHeaderCollectionReusableView
        else { return UICollectionReusableView() }
        headerSeller.label.font = SCLabel(frame: .zero, weight: .bold, size: 20).font
        headerSeller.label.text = "Daftar Jual Saya"
        headerSeller.margin = .init(top: 16, left: 0, bottom: 0, right: 0)
        return headerSeller
    }
    
}
