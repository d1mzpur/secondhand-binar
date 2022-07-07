//
//  SCSellerCategoryCollectionView.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 7/6/22.
//

import UIKit

class SCSellerCategoryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource{
    var categoryTitle: [String] = []
    var selectedCategoryIndex: Int = 0
    var viewController: SCSellerProductListViewController = SCSellerProductListViewController()
    
    init( viewController: SCSellerProductListViewController = SCSellerProductListViewController(), categoryTitleArray: [String] = []){
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        self.viewController = viewController
        self.categoryTitle = categoryTitleArray
        self.delegate = self
        self.dataSource = self
        self.register(SCCategoryChipCollectionViewCell.self, forCellWithReuseIdentifier: "categoryChips")
        self.collectionViewLayout = LayoutSection.createSellerCategory()
        self.backgroundColor = .white
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryChips", for: indexPath) as! SCCategoryChipCollectionViewCell
        categoryCell.textTitle.text = categoryTitle[indexPath[1]]
        let selected = selectedCategoryIndex == indexPath[1]
        categoryCell.cellClicked(state: selected)
        return categoryCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryChips", for: indexPath) as! SCCategoryChipCollectionViewCell
        categoryCell.onCellTapByIndex?(indexPath)
        selectedCategoryIndex = indexPath[1]
        print("Tap ", selectedCategoryIndex)
        collectionView.reloadData()
        viewController.selectedCategory = categoryTitle[indexPath[1]]
        viewController.viewDidLoad()
    }
}
