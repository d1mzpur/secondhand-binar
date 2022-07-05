//
//  SCSellerProductListViewController2.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 6/30/22.
//

import UIKit

class SCSellerProductListViewController2: UIViewController {
    var sellerView = SCSellerProfileView()
    var user: User = User.createData()
    var dataProduct: [ProductItem] = ProductItem.createData()
    var selectedCategoryIndex: Int = 0
    var productListType: String = "table"
    let categoryTitle: [String] = ["Produk","Diminati","Terjual"]
    
    lazy var textTitle: UILabel = {
        var textTitle = UILabel()
        textTitle.text = "Daftar Jual Saya"
        textTitle.font = SCLabel(frame: .zero, weight: .bold, size: 20).font
        textTitle.textColor = .black
        return textTitle
    }()
    lazy var sellerCategory: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    lazy var sellerCollection: SCSellerCollectionView = SCSellerCollectionView()
    lazy var sellerTableView: SCSellerTableView = SCSellerTableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
        view.addSubview(textTitle)
        view.addSubview(sellerView)
        view.addSubview(sellerCategory)
        sellerCategory.delegate = self
        sellerCategory.dataSource = self
        sellerCategory.register(SCCategoryChipCollectionViewCell.self, forCellWithReuseIdentifier: "categoryChips")
        sellerCategory.collectionViewLayout = LayoutSection.createSellerCategory()
        sellerCategory.backgroundColor = .white
        sellerCategory.showsVerticalScrollIndicator = false
        sellerCategory.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        sellerCollection.removeFromSuperview()
        sellerTableView.removeFromSuperview()
        switch( categoryTitle[selectedCategoryIndex] ){
        case "Produk":
            view.addSubview(sellerCollection)
            setupCollection()
            break;
        case "Diminati":
            view.addSubview(sellerTableView)
            setupTableView()
            break;
        case "Terjual":
            break;
        default:
            break;
        }
        
        
        setupConstraint()
    }

    
    private func configureView() {
        sellerView.configure(user: user)
    }
    
    private func setupCollection() {
        NSLayoutConstraint.activate([
            sellerCollection.topAnchor.constraint(equalTo: sellerCategory.bottomAnchor, constant: 8),
            sellerCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sellerCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sellerCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupTableView() {
        NSLayoutConstraint.activate([
            sellerTableView.topAnchor.constraint(equalTo: sellerCategory.bottomAnchor, constant: 8),
            sellerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sellerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sellerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupConstraint() {
        textTitle.translatesAutoresizingMaskIntoConstraints = false
        sellerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            sellerView.topAnchor.constraint(equalTo: textTitle.bottomAnchor, constant: 16),
            sellerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sellerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            sellerCategory.topAnchor.constraint(equalTo: sellerView.bottomAnchor, constant: 8),
            sellerCategory.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sellerCategory.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sellerCategory.heightAnchor.constraint(equalToConstant: 60),
    
        ])
    }
}

extension SCSellerProductListViewController2: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
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
        self.viewDidLoad()
    }
}

