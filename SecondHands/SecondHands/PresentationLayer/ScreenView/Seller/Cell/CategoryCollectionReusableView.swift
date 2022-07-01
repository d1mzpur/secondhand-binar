//
//  CategoryCollectionReusableView.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 30/06/22.
//

import UIKit

class CategoryCollectionReusableView: UICollectionReusableView {
    var collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var productItem: [ProductItem]?
    var selectedCategoryIndex: Int = -1
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        self.addSubview(collection)
        
        setupConstraint()
    }
    
    func configure(product: [ProductItem]) {
        self.productItem = product
    }
    
    func setupCollectionView() {
        self.collection = UICollectionView(frame: .zero, collectionViewLayout: LayoutSection.createLayoutCategory())
        self.backgroundColor = .systemBlue
        self.collection.backgroundColor = .white
        self.collection.delegate = self
        self.collection.dataSource = self
        self.collection.register(SCCategoryChipCollectionViewCell.self, forCellWithReuseIdentifier: "categorySeller")
        
        
    }

    private func setupConstraint() {
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: self.topAnchor),
            collection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCollectionReusableView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productItem?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "categorySeller", for: indexPath) as? SCCategoryChipCollectionViewCell
//            let item = self.productItem?[indexPath.item].productCategory
        else { return UICollectionViewCell() }
        let selected = selectedCategoryIndex == indexPath[1]
        cell.cellClicked(state: selected)
//        cell.configure(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryCell = collection.cellForItem(at: indexPath) as? SCCategoryChipCollectionViewCell
        
        categoryCell?.onCellTapByIndex?(indexPath)
        selectedCategoryIndex = selectedCategoryIndex != indexPath[1] ? selectedCategoryIndex : indexPath[1]
        collection.reloadData()
    }
    
    
}
