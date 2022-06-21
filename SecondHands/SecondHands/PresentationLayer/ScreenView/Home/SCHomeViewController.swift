//
//  SCHomeViewController.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 18/06/22.
//

import SwiftUI

typealias item = [ProductItem]

class SCHomeViewController: UIViewController {
    var productItem: item = [ProductItem(id: "1", productImage: "productImage", productTitle: "Apple Watch", productCategory: "Smart Watch", productPrice: "300.000"),
                                  ProductItem(id: "2", productImage: "productImage", productTitle: "Samsung Watch", productCategory: "Smart Watch", productPrice: "400.000"),
                                  ProductItem( id: "3", productImage: "productImage", productTitle: "iPhone 13", productCategory: "Smartphone", productPrice: "500.000"),
                                  ProductItem( id: "4", productImage: "productImage", productTitle: "Samsung Galaxy S20", productCategory: "Smartphone", productPrice: "250.000"),
                                  ProductItem( id: "5", productImage: "productImage", productTitle: "AirPods Pro", productCategory: "Air pods", productPrice: "300.000"),
                                  ProductItem( id: "6", productImage: "productImage", productTitle: "Sony Alpha A6300", productCategory: "Mirrorless", productPrice: "400.000"),
                                  ProductItem(id: "7", productImage: "productImage", productTitle: "Dji Mavic Air", productCategory: "Drone", productPrice: "500.000"),
                                  ProductItem(id: "8", productImage: "productImage", productTitle: "Macbook Pro", productCategory: "Laptop", productPrice: "250.000"),
                                  ProductItem( id: "3", productImage: "productImage", productTitle: "iPhone 13", productCategory: "Smartphone", productPrice: "500.000"),
                                  ProductItem( id: "4", productImage: "productImage", productTitle: "Samsung Galaxy S20", productCategory: "Smartphone", productPrice: "250.000"),
                                  ProductItem( id: "5", productImage: "productImage", productTitle: "AirPods Pro", productCategory: "Air pods", productPrice: "300.000"),
                                  ProductItem( id: "6", productImage: "productImage", productTitle: "Sony Alpha A6300", productCategory: "Mirrorless", productPrice: "400.000"),
                                  ProductItem(id: "7", productImage: "productImage", productTitle: "Dji Mavic Air", productCategory: "Drone", productPrice: "500.000"),
                                  ProductItem(id: "8", productImage: "productImage", productTitle: "Macbook Pro", productCategory: "Laptop", productPrice: "250.000"),
                                  ]
    var selectedCategoryIndex: Int = -1
    
    let offerItem = OfferItem(id: "1",
                              bannerImage: "offerImage",
                              bannerTitle: "Bulan Ramadhan\nBanyak Dison",
                              discount: "60%")
    
    lazy var searchBar: UISearchBar = {
        let frameNavBar = navigationController?.navigationBar.frame
        let frameWidth: CGFloat = frameNavBar?.width ?? 0
        let frameHeight: CGFloat = frameNavBar?.height ?? 0
        let frameSearchBar = CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight)
        
        var searchBar = UISearchBar(frame: frameSearchBar)
        searchBar.placeholder = "Search item"
        return searchBar
    }()
    
    lazy var searchView = SCSearchBar()
    
    let homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let gradientLayer = CAGradientLayer()
    private var lastContentOffset: CGFloat = 0
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        deleteBackgroundTopBar()
        createSearchBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupAddView()
        setupCollection()
        setupConstraint()
    }
    
    func setupAddView() {
        view.addSubview(homeCollectionView)
    }
    
    func configureView() {
        homeCollectionView.collectionViewLayout = LayoutSection.createLayout(getHeightSuperView: self.getTopbarHeight)
        homeCollectionView.backgroundColor = .white
    }
    
    func setupCollection() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.register(SCBannerCollectionViewCell.self, forCellWithReuseIdentifier: "banner")
        homeCollectionView.register(SCCategoryChipCollectionViewCell.self, forCellWithReuseIdentifier: "categoryChips")
        homeCollectionView.register(SCProductCardViewCollectionViewCell.self, forCellWithReuseIdentifier: "productList")
        homeCollectionView.register(CategorySectionCollectionReusableView.self, forSupplementaryViewOfKind: "categoryId", withReuseIdentifier: CategorySectionCollectionReusableView.reuseIdentifier)
    }
    
    func createSearchBar() {
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
    
    func setupConstraint() {
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint.priority = .defaultLow
        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomConstraint
        ])
    }
}

extension SCHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return productItem.count
        } else {
            return productItem.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productItem = self.productItem[indexPath.item]
        let offerItem = self.offerItem
        let section = indexPath.section
        
        guard
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "banner", for: indexPath) as? SCBannerCollectionViewCell,
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryChips", for: indexPath) as? SCCategoryChipCollectionViewCell,
            let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "productList", for: indexPath) as? SCProductCardViewCollectionViewCell
        else { return UICollectionViewCell() }
        
        if section == 0 {
            bannerCell.configure(item: offerItem)
            let heightBanner = bannerCell.frame.height + 80
            bannerCell.layer.insertSublayer(setGradientBackground(), at: 0)
            gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: heightBanner)
            
            return bannerCell
        } else if section == 1 {
            categoryCell.configure(item: productItem)
            let selected = selectedCategoryIndex == indexPath[1]
            categoryCell.cellClicked(state: selected)
            return categoryCell
        } else {
            productCell.configure(item: productItem)
            return productCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            guard
                let headerOfCategory = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategorySectionCollectionReusableView.reuseIdentifier, for: indexPath) as? CategorySectionCollectionReusableView
            else { return UICollectionReusableView() }
            headerOfCategory.label.text = "Telusuri Kategori"
        
            return headerOfCategory
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let data = productItem[indexPath.row]
        if ((collectionView.dequeueReusableCell(withReuseIdentifier: "categoryChips", for: indexPath) as? SCCategoryChipCollectionViewCell) != nil){
            selectedCategoryIndex = selectedCategoryIndex != indexPath[1] ? indexPath[1] : -1
            print("Tap ", indexPath[1])
            collectionView.reloadData()
        }
    }
}

extension SCHomeViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 150
        if offset > 1 {
            offset = 1
            self.navigationController?.navigationBar.barTintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
        } else {
            self.navigationController?.navigationBar.barTintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
        }
    }
    
}

extension UIViewController {
    var getTopbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}

extension SCHomeViewController {
    func getHeightSuperView() -> CGFloat {
        let heightStatusBar = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let heightNavbar = navigationController?.navigationBar.frame.height ?? 0
        return heightStatusBar + heightNavbar
    }
    
    func deleteBackgroundTopBar() {
        navigationController?.navigationBar.isHidden = true
        let colorTop =  UIColor.red //your status bar color
        let colorBottom = UIColor.white//color for your navigation bar
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [  colorBottom]
        gradientLayer.locations = [ 0.5, 0.5]
        gradientLayer.frame = CGRect(x: 0, y: -20, width: 375, height: 64)
        
        navigationController?.navigationBar.barTintColor = colorTop
        //        navigationController?.navigationBar.backgroundColor = .red
        //              self.navigationController?.navigationBar.layer.addSublayer(gradientLayer)
    }
    
    func setGradientBackground() -> CAGradientLayer {
        let colorTop =  UIColor(red: 1, green: 0.914, blue: 0.788, alpha: 1).cgColor
        let colorBottom = UIColor(red: 1, green: 0.914, blue: 0.792, alpha: 0).cgColor
        
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0, 1]
        
        return gradientLayer
    }
}
