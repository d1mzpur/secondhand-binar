//
//  SCNotificationViewController.swift
//  SecondHands
//
//  Created by Dimas Purnomo on 30/06/22.
//

import UIKit

class SCNotificationViewController: UIViewController {
    lazy var titleLabel: SCLabel = SCLabel( weight: .bold, size: 24)
    var NotificationTableView: UITableView = UITableView()
    var service = NetworkServices()
    var dataProduct: [NotifItem] = []{
        didSet{
            NotificationTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func getNotif() {
        service.getNotif(){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let itemResults):
                DispatchQueue.main.async {
                    self.dataProduct = itemResults
                }
                
            case .failure(let error):
                debugPrint(error)
                print("Error: ",error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.text = "Notifikasi"
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(NotificationTableView)
        setupTableView()
        setupConstraint()
        getNotif()
        
    }
    
    private func setupTableView() {
        NotificationTableView.delegate = self
        NotificationTableView.dataSource = self
        NotificationTableView.register(SCNotificationItemTableView.self, forCellReuseIdentifier: "NotificationProductList")
    }
    
    
    private func setupConstraint() {
        NotificationTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            NotificationTableView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 44),
            NotificationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            NotificationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            NotificationTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
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
    func fill(data:NotifItem){
        item.productImage.loadImage(resource: data.product?.imageURL)
        item.productTitle.text = data.productName
        item.productPrice.text = "Rp "+String(describing: data.basePrice)
        item.productOfferPrice.text = data.bidPrice != nil ? "Ditawar Rp "+String(describing: data.bidPrice!) : ""
    }
    
    private lazy var item: SCSellerItem = SCSellerItem()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
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

