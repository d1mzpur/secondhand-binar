//
//  SCSellerUploadViewController.swift
//  SecondHands
//
//  Created by Tatang Sulaeman on 21/06/22.
//

import UIKit

class SCSellerUploadViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.barTintColor = .white
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.black
        let image = UIImage(systemName: "arrow.left")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButton))
    }
    
    lazy var formProductName: SCFormItem = SCFormItem( formType: .normal, formName: "Nama Produk", placeholder: "Nama Produk")
    
    lazy var formProductPrice: SCFormItem = SCFormItem(formType: .normal, formName: "Harga Produk", placeholder: "Rp.0.00")
    
    lazy var formCategory: SCFormItem = SCFormItem(formType: .pickerView, formName: "Kategori", placeholder: "Pilih Kategori")
    
    lazy var formDescription: SCFormItem = SCFormItem(formType: .area, formName: "Deskripsi", placeholder: "Contoh: Jalan Ikan Hiu 33")
    
    lazy var labelImagePicker: SCLabel = SCLabel(weight: .regular, size: 14)
    
    lazy var imagePickerProduct: SCImagePicker = SCImagePicker(delegate: self, style: .style2, completionHandler: { (image) in print("image:", image)})
    
    lazy var previewButton: SCButton = SCButton(style: .secondary, size: .normal, type: .defaultButton, title: "Preview")
    
    lazy var uploadButton: SCButton = SCButton(style: .primary, size: .normal, type: .defaultButton, title: "Terbitkan")
    
    lazy var formStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [
       formProductName,
       formProductPrice,
       formCategory,
       formDescription,
       ])
        stack.setCustomSpacing(16, after: formProductName)
        stack.setCustomSpacing(16, after: formProductPrice)
        stack.setCustomSpacing(16, after: formCategory)
        stack.axis = .vertical
        return stack
    }()
    
    lazy var buttonStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [
       previewButton,
       uploadButton
       ])
        stack.setCustomSpacing(20, after: previewButton)
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lengkapi Detail Produk"
        view.backgroundColor = .white
        formCategory.dataList = [
        "Elektronik","Mainan"
        ]
        labelImagePicker.text = "Foto Produk"
//        imagePickerProduct.layer.borderWidth = 1
        view.addSubview(formStack)
        view.addSubview(labelImagePicker)
        view.addSubview(imagePickerProduct)
        view.addSubview(buttonStack)
        
        formStack.translatesAutoresizingMaskIntoConstraints = false
        labelImagePicker.translatesAutoresizingMaskIntoConstraints = false
        imagePickerProduct.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            formStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 106),
            formStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            labelImagePicker.topAnchor.constraint(equalTo: formStack.bottomAnchor, constant: 16),
            labelImagePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            imagePickerProduct.topAnchor.constraint(equalTo: labelImagePicker.bottomAnchor, constant: 16),
            imagePickerProduct.widthAnchor.constraint(equalToConstant: 96),
            imagePickerProduct.heightAnchor.constraint(equalToConstant: 96),
            imagePickerProduct.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            buttonStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc
    func backButton() {
        self.navigationController?.popViewController(animated: true)
    }
}