//
//  SCSellerProductListViewController2.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 6/30/22.
//

import UIKit

class SCSellerProductOfferViewController: UIViewController {
    var sellerView: SCSellerProfileView = SCSellerProfileView(showEdit: false)
    var buyer: UserOrder?
    var dataProduct: [OrderItem] = []{
        didSet{
            print("reload == ",dataProduct)
            sellerTableView.reloadData()
        }
    }
    
    func getOrder(status: OrderStatus) {
        NetworkServices().getOrder(status: status) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let itemResults):
                DispatchQueue.main.async {
                    let filterProduct = itemResults.filter{ item in item.user.id == self.buyer?.id }
                    self.dataProduct = filterProduct
                }
            case .failure(let error):
                print("Error: ",error.localizedDescription)
            }
        }
    }
    
    
    func patchOrder(id:Int, status:String) {
        NetworkServices().sellerPatchOrder(id: id, status: status){ [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.getOrder(status: .all)
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

        sellerView.imageSeller.loadImage(resource: buyer?.imageUrl)
        sellerView.sellerCity.text = buyer?.city ?? "Indonesia"
        sellerView.usernameSeller.text = buyer?.fullName
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
    var data:OrderItem?
    func fill(data:OrderItem, delegate:SCSellerProductOfferViewController){
        self.delegate = delegate
        self.data = data
        item.productImage.loadImage(resource: data.imageProduct)
        item.productTitle.text = data.productName
        item.productPrice.text = "Rp "+String(describing: data.basePrice)
        if  data.status == "pending"{
            print("masuk111")
            item.addbutton(
                button1Name: "Tolak",
                button2Name: "Terima"
            )
            item.actionButton1.addTarget(self, action: #selector(tolakAction), for: .touchUpInside)
            item.actionButton2.addTarget(self, action: #selector(terimaAction), for: .touchUpInside)
        }
        if data.status == "accepted"{
            print("masuk2222")
            item.addbutton(
                button1Name: "Status",
                button2Name: "Hubungi"
            )
            item.actionButton1.addTarget(self, action: #selector(statusAction), for: .touchUpInside)
            item.actionButton2.addTarget(self, action: #selector(hubungiction), for: .touchUpInside)
        }
    }
    
    @objc func terimaAction() {
        let vc = SCModalContactsViewController()
        vc.buyerLabel.text = data?.user.fullName
        vc.buyerCityLabel.text = "Indonesia"
        vc.productPicture.loadImage(resource: data?.imageProduct)
        vc.productLabel.text = data?.productName
        vc.productPriceLabel.text = "Rp \((data?.basePrice)!)"
        vc.productPriceNegoLabel.text  = "Ditawar Rp \((data?.price)!)"
        vc.modalPresentationStyle = .overCurrentContext
        delegate?.present(vc, animated: false)
        let filterProduct = delegate?.dataProduct.filter{ item in item.id != self.data?.id}
        delegate?.dataProduct = filterProduct ?? []
        delegate?.patchOrder(id: data?.id ?? 0, status: "accepted")
    }
    
    @objc func tolakAction(){
        delegate?.patchOrder(id: data?.id ?? 0, status: "declined")
    }
    
    @objc func statusAction(){
        let vc = SCModalTransactionViewController()
        vc.modalPresentationStyle = .overCurrentContext
        delegate?.present(vc, animated: false)
    }
    
    @objc func hubungiction(){
        let vc = SCModalContactsViewController()
        vc.modalPresentationStyle = .overCurrentContext
        delegate?.present(vc, animated: false)
    }
    
    
    
    private lazy var item: SCSellerItem = SCSellerItem()


    
    
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
