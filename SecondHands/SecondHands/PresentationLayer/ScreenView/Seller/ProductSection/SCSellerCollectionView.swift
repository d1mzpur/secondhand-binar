//
//  SCSellerCollectionView.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 7/4/22.
//

import Foundation
import UIKit

class SCSellerCollectionView: UICollectionView,UICollectionViewDelegate, UICollectionViewDataSource{
    var dataProduct: [ProductItem] = ProductItem.createData()
    
    init(){
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        self.delegate = self
        self.dataSource = self
        self.register(SCAddProductCollectionViewCell.self, forCellWithReuseIdentifier: "addProdcut")
        self.register(SCProductCardViewCollectionViewCell.self, forCellWithReuseIdentifier: "sellerProduct")
        self.collectionViewLayout = LayoutSection.createSellerProduct()
        self.backgroundColor = .white
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProduct.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let addProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addProdcut", for: indexPath) as? SCAddProductCollectionViewCell,
              let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sellerProduct", for: indexPath) as? SCProductCardViewCollectionViewCell
        else { return UICollectionViewCell() }
        
        let item = indexPath.item
        let data = self.dataProduct[item > 0 ? item - 1 : item]
        if item == 0 {
            return addProductCell
        } else {
            productCell.configure(item: data)
            return productCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let _ = collectionView.cellForItem(at: indexPath) as? SCProductCardViewCollectionViewCell else { return }
    }
}
