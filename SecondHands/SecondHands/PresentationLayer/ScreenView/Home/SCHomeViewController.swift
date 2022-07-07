//
//  SCHomeViewController.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 18/06/22.
//

import SwiftUI

class SCHomeViewController: UIViewController {
    var productItem: [ProductItem]?
    var offerItem: [OfferItem]?
    var category: [Categories]?
    var newCategory: [Categories]? {
        var newCategoryItem = self.category.map { $0 }
        newCategoryItem?.insert(Categories(id: 0, name: "Semua", createdAt: "", updatedAt: ""), at: 0)
        
        return newCategoryItem
    }
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
        createSearchBar()
        setupConstraint()
        getBanner()
        getCategory()
        getProduct()
    }
    
    func setupAddView() {
        view.addSubview(homeCollectionView)
    }
    
    func getBanner() {
        service.getBanner { result in
            switch result {
            case .success(let success):
                self.offerItem = success
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCategory() {
        service.getCategory { (result) in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.category = result
                    self.homeCollectionView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getProduct() {
        service.getProduct(by: .buyer) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let itemResults):
                DispatchQueue.main.async {
                    self.productItem = itemResults
                    self.filterListProduct = self.productItem
                    self.homeCollectionView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
            
        ])
    }
}

extension SCHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return offerItem?.count ?? 0
        } else if section == 1 {
            return newCategory?.count ?? 0
        } else {
            return isProductEmpty()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "banner", for: indexPath) as? SCBannerCollectionViewCell,
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryChips", for: indexPath) as? SCCategoryChipCollectionViewCell,
            let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "productList", for: indexPath) as? SCProductCardViewCollectionViewCell
        else { return UICollectionViewCell() }
        
        let section = indexPath.section
        let item = indexPath.item + 1
        let newItem = item > 0 ? item - 1 : item
        
        let productList = self.productItem?[indexPath.item]
        
        if section == 0 {
            let offerItem = self.offerItem?[indexPath.row]
            bannerCell.configure(item: offerItem ?? .init(bannerId: 0, bannerImage: "", bannerTitle: "", createdAt: "", updatedAt: ""))
            
            return bannerCell
        } else if section == 1 {
            let selected = selectedCategoryIndex == indexPath[1]
            categoryCell.cellClicked(state: selected)
            categoryCell.onCellTapByIndex = { cellTapByIndex in
                print("==>> Update by filter = ", self.newCategory?[cellTapByIndex.item].name)
                self.filterListProduct = self.productItem.map { $0 }?.filter { $0.productCategory!.contains { $0.name == self.newCategory?[cellTapByIndex.item].name } }
                
                let encode = try? JSONEncoder().encode(self.filterListProduct)
                let serial = try? JSONSerialization.jsonObject(with: encode ?? Data(), options: .allowFragments)
                print(serial)
                
                collectionView.reloadData()
                print("== RELOAD DATA ==")
            }
            categoryCell.configure(item: self.newCategory?[indexPath.row].name ?? "")
            return categoryCell
            
            
        } else {
            guard let item = filterListProduct?.isEmpty == nil ? productList : filterListProduct?[newItem] else { return UICollectionViewCell() }
            productCell.configure(item: item)
            return productCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.item
        let newItem = item > 0 ? item - 1 : item
        let indexPATH = IndexPath(item: newItem, section: 1)
        switch indexPath.section {
        case 0:
            guard let _ = homeCollectionView.cellForItem(at: indexPath) as? SCBannerCollectionViewCell else { return }
        case 1:
            let categoryCell = collectionView.cellForItem(at: indexPATH) as? SCCategoryChipCollectionViewCell

                categoryCell?.onCellTapByIndex?(indexPath)
            selectedCategoryIndex = selectedCategoryIndex != indexPath[1] ? indexPath[1] : -1
            if selectedCategoryIndex == 0 {
                filterListProduct = productItem
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
    
    
}

extension SCHomeViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 150
        if offset > -0.5 {
            offset = 1
            self.navigationController?.navigationBar.barTintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 0)
            self.navigationController?.navigationBar.backgroundColor = .LimeGreen03
        } else {
            self.navigationController?.navigationBar.barTintColor = .white
        }
    }
    
    func createCategoryList() -> [String] {
        var categories = [String]()
        let product =  productItem?.compactMap { $0.productCategory?.compactMap { $0.name }}
        product?.forEach({ (category) in categories.append(contentsOf: category) })
        return Set(categories).compactMap { $0.capitalized }
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
        return (self.filterListProduct?.isEmpty) == true ? Int(self.productItem?.count ?? 0) : Int(self.filterListProduct?.count ?? 0)
        
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
