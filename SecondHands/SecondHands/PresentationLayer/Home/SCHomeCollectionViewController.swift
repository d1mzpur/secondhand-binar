//
//  SCHomeCollectionViewController.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 15/06/22.
//

import SwiftUI

private let reuseIdentifier = "Cell"

enum ItemType: String, CaseIterable {
    case banners = "0"
    case chip = "1"
    case cardView = "2"
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
    
    let item = [ ItemProduct(id: "1", productImage: "productImage", productTitle: "Puma Archive", productCategory: "Sepatu Casual", productPrice: "250.000"),
                 ItemProduct(id: "2", productImage: "productImage", productTitle: "Puma Bold", productCategory: "Tas", productPrice: "300.000"),
                 ItemProduct(id: "3", productImage: "productImage", productTitle: "Puma Futsal", productCategory: "Celana", productPrice: "400.000"),
                 ItemProduct(id: "4", productImage: "productImage", productTitle: "Puma Bola", productCategory: "Tenda Biru", productPrice: "500.000"),
                 ItemProduct(id: "1", productImage: "productImage", productTitle: "Puma Archive", productCategory: "Peralatan Rumah Tangga", productPrice: "250.000"),
                 ItemProduct(id: "2", productImage: "productImage", productTitle: "Puma Bold", productCategory: "Sayur - Sayuran", productPrice: "300.000"),
                 ItemProduct(id: "3", productImage: "productImage", productTitle: "Puma Futsal", productCategory: "Buah - Buahan", productPrice: "400.000"),
                 ItemProduct(id: "4", productImage: "productImage", productTitle: "Puma Bola", productCategory: "Laptop", productPrice: "500.000")
    ]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        bannerCellRegistrasion = UICollectionView.CellRegistration(handler: { (cell: SCProductCardViewCollectionViewCell, _, item: ItemProduct) in
            cell.setup(item: item)
        })
        
        categoryCellRegistration = UICollectionView.CellRegistration(handler: { (cell: SCCategoryChipCollectionViewCell, _, item: ItemProduct) in
            cell.textTitle.text = item.productCategory
        })
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(CategorySectionCollectionReusableView.self, forSupplementaryViewOfKind: SCHomeCollectionViewController.categoryId, withReuseIdentifier: headerId)
        
        createSearchBar()
        configureView()
        createTransparantNavBar()
    }
    
    var bannerCellRegistrasion: UICollectionView.CellRegistration<SCProductCardViewCollectionViewCell, ItemProduct>!
    var categoryCellRegistration: UICollectionView.CellRegistration<SCCategoryChipCollectionViewCell, ItemProduct>!
    
    func createSearchBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
    
    private func createTransparantNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
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
                
                section.orthogonalScrollingBehavior = .groupPagingCentered
                return section
            case .chip:
                let itemCategory = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .estimated(100),
                        heightDimension: .estimated(50)))

                
                let group = NSCollectionLayoutGroup
                    .horizontal(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .estimated(50)),
                        subitems: [itemCategory])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: categoryId, alignment: .topLeading)
                ]
                
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
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
//        header.backgroundColor = .systemBlue
//        header.clipsToBounds = true
        return header
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else if section == 1 {
            return 8
        } else {
            return 24
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = item[indexPath.item]
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            cell.backgroundColor = .systemYellow
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueConfiguredReusableCell(using: categoryCellRegistration, for: indexPath, item: data)
            return cell
        } else {
            let cell = collectionView.dequeueConfiguredReusableCell(using: bannerCellRegistrasion, for: indexPath, item: data)
//                .createRounded(radius: 4)
//            cell.container.backgroundColor = .systemGray6
            cell.backgroundColor = .gray
            return cell
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

