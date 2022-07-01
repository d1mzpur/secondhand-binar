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
    var selectedCategoryIndex: Int = -1
    var productListType: String = "table"
    
    lazy var textTitle: UILabel = {
        var textTitle = UILabel()
        textTitle.text = "Daftar Jual Saya"
        textTitle.font = SCLabel(frame: .zero, weight: .bold, size: 20).font
        textTitle.textColor = .black
        return textTitle
    }()
    lazy var sellerCollection: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    lazy var sellerTableView: UITableView = UITableView()
    
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
        sellerView.addAction(#selector(switchView), target: self)
        if productListType == "collection"{
            view.addSubview(sellerCollection)
            setupCollection()
        }
        else{
            view.addSubview(sellerTableView)
            setupTableView()
        }
        setupConstraint()
    }
    
    @objc func switchView(){
        if productListType == "collection"{
            productListType = "table"
        }
        else{
            productListType = "collection"
        }
        self.viewDidLoad()

    }
    
    private func setupCollection() {
        sellerCollection.delegate = self
        sellerCollection.dataSource = self
        sellerCollection.register(SCAddProductCollectionViewCell.self, forCellWithReuseIdentifier: "addProdcut")
        sellerCollection.register(SCProductCardViewCollectionViewCell.self, forCellWithReuseIdentifier: "sellerProduct")
        sellerCollection.collectionViewLayout = LayoutSection.createSellerProduct()
        sellerCollection.backgroundColor = .white
        sellerCollection.showsVerticalScrollIndicator = false
        sellerCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sellerCollection.topAnchor.constraint(equalTo: sellerView.bottomAnchor, constant: 8),
            sellerCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sellerCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sellerCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupTableView() {
        sellerTableView.delegate = self
        sellerTableView.dataSource = self
        sellerTableView.register(SCSellerItemTableView.self, forCellReuseIdentifier: "sellerProductList")
        sellerTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sellerTableView.topAnchor.constraint(equalTo: sellerView.bottomAnchor, constant: 8),
            sellerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sellerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sellerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureView() {
        sellerView.configure(user: user)
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
    
        ])
    }
}

extension SCSellerProductListViewController2: UICollectionViewDelegate, UICollectionViewDataSource {
    
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

extension SCSellerProductListViewController2: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sellerProductList", for: indexPath) as! SCSellerItemTableView
       
        
        cell.fill(data: dataProduct[indexPath.row])
        return cell
    }
    
    
}

class SCSellerItemTableView: UITableViewCell{
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

