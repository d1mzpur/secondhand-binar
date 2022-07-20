//
//  SCSellerProductListViewController2.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 6/30/22.
//

import UIKit

class SCSellerProductOfferViewController: UIViewController {
    var sellerView = SCSellerProfileView()
    var user: User = User.createData()
    var dataProduct: [ProductItem] = []
 
    lazy var offerLabel: SCLabel = SCLabel( weight: .medium, size: 14)
    lazy var sellerTableView: UITableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.barTintColor = .white
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.black
        let image = UIImage(systemName: "arrow.left")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButton))
    }
    
    @objc func backButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Info Penawar"
        view.backgroundColor = .white
        
        sellerView.configure(user: user)
        view.addSubview(sellerView)
        
        offerLabel.text = "Daftar Produkmu yang Ditawar"
        view.addSubview(offerLabel)

        sellerTableView.delegate = self
        sellerTableView.dataSource = self
        sellerTableView.register(SCSellerProductOfferViewControllerCell.self, forCellReuseIdentifier: "sellerProductList")
        sellerTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sellerTableView)
        setupConstraint()
    }
    
    private func setupConstraint() {
        sellerView.translatesAutoresizingMaskIntoConstraints = false
        offerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            sellerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 106),
            sellerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sellerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            offerLabel.topAnchor.constraint(equalTo: sellerView.bottomAnchor, constant: 16),
            offerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            offerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            sellerTableView.topAnchor.constraint(equalTo: offerLabel.bottomAnchor, constant: 8),
            sellerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sellerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sellerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

    
        ])
    }
}

extension SCSellerProductOfferViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sellerProductList", for: indexPath) as! SCSellerProductOfferViewControllerCell
        cell.fill(data: dataProduct[indexPath.row])
        return cell
    }
}

class SCSellerProductOfferViewControllerCell: UITableViewCell{
    func fill(data:ProductItem){
//        item.productImage
        item.productTitle.text = data.productTitle
        item.productPrice.text = String(describing: data.productPrice)
    }
    
    private lazy var item: SCSellerItem = {
        var sellerItem = SCSellerItem()
        sellerItem.addbutton(
            button1Name: "Tolak",
            button2Name: "Terima"
        )
        sellerItem.actionButton1.addTarget(self, action: #selector(tolakAction), for: .touchUpInside)
        sellerItem.actionButton2.addTarget(self, action: #selector(terimaAction), for: .touchUpInside)
        return sellerItem
    }()
    
    @objc func tolakAction(){
        print("tolak")
    }
    
    @objc func terimaAction(){
        print("terima")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.isUserInteractionEnabled = true
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
