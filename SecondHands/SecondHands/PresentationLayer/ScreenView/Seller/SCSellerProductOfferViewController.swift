//
//  SCSellerProductListViewController2.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 6/30/22.
//

import UIKit

class SCSellerProductOfferViewController: UIViewController {
    var sellerView: SCSellerProfileView = SCSellerProfileView(showEdit: false)
    var buyerName: String = ""
    var dataProduct: [NotifItem] = []{
        didSet{
            sellerTableView.reloadData()
        }
    }
    
    func getNotif() {
        NetworkServices().getNotif(){ [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.dataProduct = result
            }
        }
    }
 
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
        self.tabBarController?.tabBar.barTintColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Info Penawar"
        view.backgroundColor = .white
        
        let imageName = "userExample.png"
        let image = UIImage(named: imageName)
        sellerView.imageSeller.image = image
        sellerView.sellerCity.text = "Indonesia"
        sellerView.usernameSeller.text = buyerName
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
        cell.fill(data: dataProduct[indexPath.row],delegate: self)
        return cell
    }
}

class SCSellerProductOfferViewControllerCell: UITableViewCell{
    var delegate: SCSellerProductOfferViewController?
    var data:NotifItem?
    func fill(data:NotifItem, delegate:SCSellerProductOfferViewController){
        self.delegate = delegate
        self.data = data
        item.productImage.loadImage(resource: data.product?.imageURL)
        item.productTitle.text = data.productName
        item.productPrice.text = "Rp "+String(describing: data.basePrice)
        if  data.status == "bid"{
            item.addbutton(
                button1Name: "Tolak",
                button2Name: "Terima"
            )
            item.actionButton1.addTarget(self, action: #selector(tolakAction), for: .touchUpInside)
            item.actionButton2.addTarget(self, action: #selector(presentModalTransaction), for: .touchUpInside)
        }
        else if  data.status == "accepted"{
            item.addbutton(
                button1Name: "Status",
                button2Name: "Hubungi"
            )
            item.actionButton1.addTarget(self, action: #selector(tolakAction), for: .touchUpInside)
            item.actionButton2.addTarget(self, action: #selector(terimaAction), for: .touchUpInside)
        }
    }
    
    @objc func presentModalTransaction() {
        let vc = SCModalContactsViewController()
        vc.buyerLabel.text = delegate?.buyerName
        vc.buyerCityLabel.text = "Indonesia"
        vc.productPicture.loadImage(resource: data?.imageURL)
        vc.productLabel.text = data?.productName
        vc.productPriceLabel.text = "Rp \((data?.basePrice)!)"
        vc.productPriceNegoLabel.text  = "Rp \((data?.bidPrice)!)"
        vc.modalPresentationStyle = .overCurrentContext
        delegate?.present(vc, animated: false)
    }
    
    private lazy var item: SCSellerItem = SCSellerItem()

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
