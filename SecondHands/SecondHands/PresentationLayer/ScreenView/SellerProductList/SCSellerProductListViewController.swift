//
//  SCSellerProductListViewController2.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 6/30/22.
//

import UIKit

class SCSellerProductListViewController: UIViewController {
    var sellerView = SCSellerProfileView()
    var categoryTitleArray: [String] = ["Produk","Diminati","Terjual"]
    var service = NetworkServices()
    var dataProduct: [ProductItem] = []{
        didSet{
            sellerCollection.dataProduct = dataProduct
            sellerCollection.reloadData()
        }
    }
    var dataOrderProduct: [OrderItem] = []{
        didSet{
            sellerTableView.dataProduct = dataOrderProduct
            sellerTableView.reloadData()
        }
    }

    
    var selectedCategory: String = "Produk"
    lazy var textTitle: UILabel = {
        var textTitle = UILabel()
        textTitle.text = "Daftar Jual Saya"
        textTitle.font = SCLabel(frame: .zero, weight: .bold, size: 20).font
        textTitle.textColor = .black
        return textTitle
    }()
    
    lazy var sellerCategory: SCSellerCategoryCollectionView = SCSellerCategoryCollectionView(viewController: self, categoryTitleArray: categoryTitleArray)
    lazy var sellerCollection: SCSellerProductCollectionView = SCSellerProductCollectionView(viewController: self)
    lazy var sellerTableView: SCSellerProductTableView = SCSellerProductTableView(viewController: self)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    
    func getUser() {
        NetworkServices().getUserAlamofire() { (result) in
            DispatchQueue.main.async {
                let user = User(
                    imageUser: result.image ?? "",
                    userName: result.fullName ?? "",
                    city: result.city ?? ""
                )
                self.sellerView.configure(user: user)
            }
        }
    }
    
    func getProduct() {
        service.getProduct(by: .seller) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.dataProduct = result
                self.sellerTableView.reloadData()
            }
        }
    }
    
    func getOrder(status: OrderStatus) {
        service.getOrder(status: status) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let itemResults):
                DispatchQueue.main.async {
                    self.dataOrderProduct = itemResults
                }
            case .failure(let error):
                print("Error: ",String(describing: error))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(textTitle)
        view.addSubview(sellerView)
        view.addSubview(sellerCategory)
        sellerView.editButton.addAction(#selector(goToEditProfile), target: self)
        getUser()
        sellerCollection.removeFromSuperview()
        sellerTableView.removeFromSuperview()
//        let indexPath = IndexPath(item: 0, section: 0)
        switch( selectedCategory ){
        case "Produk":
            view.addSubview(sellerCollection)
            setupCollection()
            getProduct()
            break;
        case "Diminati":
            view.addSubview(sellerTableView)
            setupTableView()
//            if let cellLabel = (sellerTableView.cellForRow(at: indexPath) as? SCSellerEmptyItemTableView)?.productLabel{
//                cellLabel.text = "Belum ada produkmu yang diminati nih, sabar ya rejeki nggak kemana kok"
//            }
            getOrder(status: .pending)
            break;
        case "Terjual":
            view.addSubview(sellerTableView)
            setupTableView()
//            if let cellLabel = (sellerTableView.cellForRow(at: indexPath) as? SCSellerEmptyItemTableView)?.productLabel{
//                cellLabel.text = "Belum ada produkmu yang terjual nih, sabar ya rejeki nggak kemana kok"
//            }
            getOrder(status: .accepted)
            break;
        default:
            break;
        }
        setupConstraint()
        
        
    }
    
    @objc func goToEditProfile(){
        tabBarController?.selectedIndex = 4
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

