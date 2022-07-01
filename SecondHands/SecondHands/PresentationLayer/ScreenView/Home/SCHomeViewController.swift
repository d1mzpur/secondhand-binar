//
//  SCHomeViewController.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 18/06/22.
//

import SwiftUI

class SCHomeViewController: UIViewController {
    var productItem: [ProductItem]?
    
    let offerItem: [OfferItem] = OfferItem.createData()
    var firstState: Bool = false
    var customSearchBar: SCSearchBar = {
        var searchBar = SCSearchBar()
        searchBar.layer.cornerRadius = 16
        searchBar.clipsToBounds = true
        searchBar.height = 44
        searchBar.margin = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16)
        searchBar.backgroundColor = .white
        
        
        return searchBar
    }()
    
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
    
    var filterListProduct: [ProductItem]? = nil
    lazy var removeDuplicate = self.productItem
    let gradientLayer = CAGradientLayer()
    var selectedCategoryIndex: Int = -1
    var service = NetworkServices()
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        selectedCategoryIndex = 0
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
        service.getProductList(by: .buyer) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let itemResults):
                self.productItem = itemResults
                self.homeCollectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        setupConstraint()
    }
    
    func setupAddView() {
        view.addSubview(homeCollectionView)
    }
    
    func configureView() {
        homeCollectionView.collectionViewLayout = LayoutSection.createHomeLayout(getHeightSuperView: self.getTopbarHeight)
        homeCollectionView.backgroundColor = .white
        homeCollectionView.showsVerticalScrollIndicator = false
    }
    
    func setupCollection() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.register(SCBannerCollectionViewCell.self, forCellWithReuseIdentifier: "banner")
        homeCollectionView.register(SCCategoryChipCollectionViewCell.self, forCellWithReuseIdentifier: "allCategoryChips")
        homeCollectionView.register(SCCategoryChipCollectionViewCell.self, forCellWithReuseIdentifier: "categoryChips")
        homeCollectionView.register(SCProductCardViewCollectionViewCell.self, forCellWithReuseIdentifier: "productList")
        homeCollectionView.register(SCHeaderCollectionReusableView.self, forSupplementaryViewOfKind: "categoryId", withReuseIdentifier: "headerCategory")
    }
    
    func createSearchBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customSearchBar)
    }
    
    func setupConstraint() {
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //        let bottomConstraint = homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        //        bottomConstraint.priority = .defaultLow
        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            //            bottomConstraint
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
            return productItem?.count ?? 0 + 1
        } else {
            return isProductEmpty()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = indexPath.item
        let newItem = item > 0 ? item - 1 : item
        let productCategory = self.productItem?[newItem]
        let section = indexPath.section
        
        
        guard
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "banner", for: indexPath) as? SCBannerCollectionViewCell,
            let allCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "allCategoryChips", for: indexPath) as? SCCategoryChipCollectionViewCell,
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryChips", for: indexPath) as? SCCategoryChipCollectionViewCell,
            let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "productList", for: indexPath) as? SCProductCardViewCollectionViewCell
        else { return UICollectionViewCell() }
        
        if section == 0 {
            let offerItem = self.offerItem[indexPath.row]
            bannerCell.configure(item: offerItem)
            let heightBanner = bannerCell.frame.height + 80
            bannerCell.layer.insertSublayer(setGradientBackground(), at: 0)
            gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: heightBanner)
            
            return bannerCell
        } else if section == 1 {
            let selected = selectedCategoryIndex == indexPath[1]
            categoryCell.cellClicked(state: selected)
            allCategoryCell.cellClicked(state: selected)
            if indexPath.item == 0 {
                allCategoryCell.configure(item: "Semua")
                filterListProduct = productItem
                return allCategoryCell
            } else {
//                let category = productCategory?.productCategory ?? ""
//                categoryCell.configure(item: category)
//
//
//                categoryCell.onCellTapByIndex = { [weak self] filter in
//
//                    guard let self = self else { return }
//                    print(self.productItem?[newItem].productCategory)
//                    self.filterListProduct = self.productItem?.filter {
//                        $0.productCategory.contains(
//                            self.productItem?[newItem]
//                                .productCategory ?? "")
//                    }
//                }
                
                return categoryCell
            }
        } else {
            guard let item = filterListProduct?.isEmpty == nil ? productCategory : filterListProduct?[indexPath.item] else { return UICollectionViewCell() }
            
            productCell.configure(item: item)
            return productCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.item
        let newItem = item > 0 ? item - 1 : item
        switch indexPath.section {
        case 0:
            guard let _ = homeCollectionView.cellForItem(at: indexPath) as? SCBannerCollectionViewCell else { return }
        case 1:
            let categoryCell = collectionView.cellForItem(at: indexPath) as?
                SCCategoryChipCollectionViewCell
            categoryCell?.onCellTapByIndex?(indexPath)
            
            if ((collectionView.dequeueReusableCell(withReuseIdentifier: "categoryChips", for: indexPath) as? SCCategoryChipCollectionViewCell) != nil) {
                selectedCategoryIndex = selectedCategoryIndex != indexPath[1] ? indexPath[1] : -1
                print("Tap ", selectedCategoryIndex, productItem?[newItem])
                collectionView.reloadData()
            }
            
        case 2:
            guard let _ = homeCollectionView.cellForItem(at: indexPath) as? SCProductCardViewCollectionViewCell else { return }
        default:
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            let headerOfCategory = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCategory", for: indexPath) as? SCHeaderCollectionReusableView
        else { return UICollectionReusableView() }
        headerOfCategory.label.font = SCLabel(frame: .zero, weight: .medium, size: 14).font
        headerOfCategory.label.text = "Telusuri Kategori"
        
        return headerOfCategory
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
    }
    
}

extension SCHomeViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 150
        if offset > 1 {
            offset = 1
            //            self.navigationController?.navigationBar.barTintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 0)
            self.navigationController?.navigationBar.backgroundColor = .LimeGreen03
        } else {
            self.navigationController?.navigationBar.barTintColor = .clear
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
    
    func isProductEmpty() -> Int {
        return (self.filterListProduct?.isEmpty) == nil ? Int(self.productItem?.count ?? 0) : Int(self.filterListProduct?.count ?? 0)
        
    }
    
    func deleteBackgroundTopBar() {
        
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
