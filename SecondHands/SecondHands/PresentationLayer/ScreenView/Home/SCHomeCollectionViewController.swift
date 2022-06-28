//
//  SCHomeCollectionViewController.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 15/06/22.
//

import SwiftUI

private let reuseIdentifier = "Cell"

enum ItemType: String, CaseIterable {
    case banners
    case chip
    case cardView
}

class SCHomeCollectionViewController: UICollectionViewController {
    
    lazy var searchBar: UISearchBar = {
        let frameNavBar = navigationController?.navigationBar.frame
        let frameWidth: CGFloat = frameNavBar?.width ?? 0
        let frameHeight: CGFloat = frameNavBar?.height ?? 0
        let frameSearchBar = CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight)
        
        var searchBar = UISearchBar(frame: frameSearchBar)
        searchBar.placeholder = "Search item"
        searchBar.searchTextField.delegate = self
        searchBar.delegate = self
        
        return searchBar
    }()
    
    init() {
        super.init(collectionViewLayout: SCHomeCollectionViewController.createLayout())
    }
    
    let item: [ProductItem] = ProductItem.createData()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        bannerRegisterCell = UICollectionView.CellRegistration(handler: { (cell: SCBannerCollectionViewCell, _, item: OfferItem) in
            
            cell.offerImage.image = UIImage(named: "offerImage")
            
            cell.discount.text = item.discount
        })
        
        categoryRegisterCell = UICollectionView.CellRegistration(handler: { (cell: SCCategoryChipCollectionViewCell, _, item: ProductItem) in
            cell.textTitle.text = item.productCategory
        })
        
        productListRegisterCell = UICollectionView.CellRegistration(handler: { (cell: SCProductCardViewCollectionViewCell, _, item: ProductItem) in
            
        })
        
//        topBar = navigationController?.navigationBar.topItem
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(SCHeaderCollectionReusableView.self, forSupplementaryViewOfKind: SCHomeCollectionViewController.categoryId, withReuseIdentifier: headerId)
        
        createSearchBar()
        configureView()
        createTransparantNavBar()
    }
    
    var bannerRegisterCell: UICollectionView.CellRegistration<SCBannerCollectionViewCell, OfferItem>!
    var categoryRegisterCell: UICollectionView.CellRegistration<SCCategoryChipCollectionViewCell, ProductItem>!
    var productListRegisterCell: UICollectionView.CellRegistration<SCProductCardViewCollectionViewCell, ProductItem>!
    
    func createSearchBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
    
    private func createTransparantNavBar() {
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, environment) -> NSCollectionLayoutSection? in
            let data = ItemType.allCases[sectionNumber]
            
            switch data {
            case .banners:
                let itemBanner = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup
                    .horizontal(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .absolute(200)),
                        subitems: [itemBanner])
                
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            case .chip:
                let itemCategory = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .estimated(100),
                        heightDimension: .absolute(44)))
                
                let group = NSCollectionLayoutGroup
                    .horizontal(
                        layoutSize: .init(
                            widthDimension: .estimated(500),
                            heightDimension: .absolute(50)),
                        subitems: [itemCategory])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: categoryId, alignment: .top)
                ]
                section.interGroupSpacing = 16
                section.contentInsets.leading = 16
                section.contentInsets.bottom = 32
                return section
            case .cardView :
                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(200))
                
                let itemCategory = NSCollectionLayoutItem(layoutSize: layoutSize)
                itemCategory.contentInsets.trailing = 16
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemCategory])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.interGroupSpacing = 16
                return section
            }
            
        }
    }
    
    let headerId = "headerId"
    static let categoryId = "categoryHeaderId"
    
    func configureView() {
        collectionView.backgroundColor = .white
//        title = "Second Hands"
    }
    
    func getHeightSuperView() -> CGFloat {
        let heightStatusBar = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let heightNavbar = navigationController?.navigationBar.frame.height ?? 0
        return heightStatusBar + heightNavbar
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
//        header.backgroundColor = .systemBlue
//        header.clipsToBounds = true
        return header
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return item.count
        } else {
            return item.count
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = item[indexPath.item]
        let item = OfferItem(id: "1", bannerImage: "offerImage", bannerTitle: "Bulan Ramadhan\nBanyak Dison", discount: "60%")
        if indexPath.section == 0 {
            let cell = collectionView.dequeueConfiguredReusableCell(using: bannerRegisterCell, for: indexPath, item: item)
            
            cell.backgroundColor = .systemYellow
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueConfiguredReusableCell(using: categoryRegisterCell, for: indexPath, item: data)
            return cell
        } else {
            let cell = collectionView.dequeueConfiguredReusableCell(using: productListRegisterCell, for: indexPath, item: data)
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = item[indexPath.row]
        if (collectionView.cellForItem(at: indexPath) != nil) {
            print("Tap ", data.productTitle)
        }
    }

}

extension SCHomeCollectionViewController: UISearchBarDelegate, UITextFieldDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        cancelButton(show: false)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        cancelButton(show: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cancelButton(show: false)
        
        return searchBar.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
        cancelButton(show: true)
    }
    
    func cancelButton(show: Bool) {
        searchBar.showsCancelButton = show
    }
}

extension UIViewController {
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
