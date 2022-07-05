//
//  SCSellerTableView.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 7/4/22.
//

import UIKit

class SCSellerTableView: UITableView, UITableViewDelegate,UITableViewDataSource{
    
    var dataProduct: [ProductItem] = ProductItem.createData()
    init(){
        super.init(frame: .zero, style: UITableView.Style.plain)
        self.delegate = self
        self.dataSource = self
        self.register(SCSellerItemTableView.self, forCellReuseIdentifier: "sellerProductList")
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
