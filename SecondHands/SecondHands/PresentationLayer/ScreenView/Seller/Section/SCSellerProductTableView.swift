//
//  SCSellerTableView.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 7/4/22.
//

import UIKit

class SCSellerProductTableView: UITableView, UITableViewDelegate,UITableViewDataSource{
    
    var dataProduct: [ProductItem] = []
    init(dataProduct: [ProductItem]){
        super.init(frame: .zero, style: UITableView.Style.plain)
        self.dataProduct = dataProduct
        self.delegate = self
        self.dataSource = self
        self.register(SCSellerItemTableView.self, forCellReuseIdentifier: "sellerProductList")
        self.register(SCSellerEmptyItemTableView.self, forCellReuseIdentifier: "sellerEmptyProductList")
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProduct.count == 0 ? 1 : dataProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataProduct.count == 0 {
            tableView.separatorStyle = .none;
            tableView.isScrollEnabled = false
            let cell = tableView.dequeueReusableCell(withIdentifier: "sellerEmptyProductList", for: indexPath) as! SCSellerEmptyItemTableView
            return cell
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "sellerProductList", for: indexPath) as! SCSellerItemTableView
        cell.fill(data: dataProduct[indexPath.row])
        return cell
    }
}

class SCSellerItemTableView: UITableViewCell{
    func fill(data:ProductItem){
//        item.productImage
        item.productTitle.text = data.productTitle
        item.productPrice.text = String(describing: data.productPrice)
    }
    
    private lazy var item = SCSellerItem()
    
    
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

class SCSellerEmptyItemTableView: UITableViewCell{
    
    lazy var productImage: UIImageView = {
        let imageName = "emptyProduct.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.autoresizingMask = [.flexibleWidth]
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var productLabel: SCLabel = {
        var lbl = SCLabel()
        lbl.text = "Belum ada produkmu yang diminati nih, sabar ya rejeki nggak kemana kok"
        lbl.numberOfLines = 2
        lbl.textColor = .Neutral03
        lbl.size = 10
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        addSubview(productImage)
        addSubview(productLabel)
        NSLayoutConstraint.activate([
            productImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            productImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            productLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 16),
            productLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            productLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            productLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
