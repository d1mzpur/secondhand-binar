//
//  SCNotificationViewController.swift
//  SecondHands
//
//  Created by Dimas Purnomo on 30/06/22.
//

import UIKit

class SCNotificationViewController: UIViewController {
    var user: User = User.createData()
    var dataProduct: [ProductItem] = ProductItem.createData()
    var selectedCategoryIndex: Int = -1
    
    lazy var registerLabel: SCLabel = SCLabel( weight: .bold, size: 24)
    
    var NotificationCollection: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var NotificationTableView: UITableView = UITableView()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
//        view.addSubview(NotificationCollection)
//        setupCollection()
        view.addSubview(registerLabel)
        registerLabel.text = "Notifikasi"
        registerLabel.textColor = .black
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(NotificationTableView)
        
        setupTableView()
        setupConstraint()
        
        
    }
    
//    private func setupCollection() {
//        NotificationCollection.delegate = self
//        NotificationCollection.dataSource = self
//        NotificationCollection.register(SCAddProductCollectionViewCell.self, forCellWithReuseIdentifier: "addProdcut")
//        NotificationCollection.register(SCProductCardViewCollectionViewCell.self, forCellWithReuseIdentifier: "sellerProduct")
//    }
    
    private func setupTableView() {
        NotificationTableView.delegate = self
        NotificationTableView.dataSource = self
//        NotificationCollection.register(SCAddProductCollectionViewCell.self, forCellWithReuseIdentifier: "addProdcut")
        NotificationTableView.register(SCNotificationItemTableView.self, forCellReuseIdentifier: "NotificationProductList")
    }
    
    private func configureView() {
//        NotificationCollection.collectionViewLayout = LayoutSection.createSellerProduct()
//        NotificationCollection.backgroundColor = .white
//        NotificationCollection.showsVerticalScrollIndicato
    }
    
    private func setupConstraint() {
        NotificationTableView.translatesAutoresizingMaskIntoConstraints = false
//        NotificationCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            registerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            registerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            registerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
//            NotificationCollection.topAnchor.constraint(equalTo: sellerView.bottomAnchor, constant: 8),
//            NotificationCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            NotificationCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            NotificationCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            NotificationTableView.topAnchor.constraint(equalTo: registerLabel.topAnchor, constant: 44),
            NotificationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            NotificationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            NotificationTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    
}

extension SCNotificationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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

extension SCNotificationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationProductList", for: indexPath) as! SCNotificationItemTableView
       
        
        cell.fill(data: dataProduct[indexPath.row])
        return cell
    }
    
    
}

class SCNotificationItemTableView: UITableViewCell{
    func fill(data:ProductItem){
//        item.productImage
        item.productTitle.text = data.productTitle
        item.productPrice.text = data.productPrice
    }
    
    private lazy var item: SCSellerItem = SCSellerItem(productImageURL: "String", productLabel: "Penawaran product", productTitle: "Jam Tangan Casio", productPrice: "Rp 250.000", discountProduct: "Ditawar Rp 200.000")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(item)
        item.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            item.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            item.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            item.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            item.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

