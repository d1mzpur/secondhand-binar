//
//  SCProfilViewController.swift
//  SecondHands
//
//  Created by Dimas Purnomo on 18/06/22.
//

import UIKit

class SCProfilViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .white
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.black
        let image = UIImage(systemName: "arrow.left")
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action:  Selector(("action")))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action:  #selector(backButton))
    }

    
    lazy var formName:  SCFormItem = SCFormItem(formType: .normal, formName: "Nama", placeholder: "contoh: johndee@gmail.com")
    lazy var formCity:  SCFormItem = SCFormItem(formType: .pickerView, formName: "Kota", placeholder: "contoh: Pilih Kota")
    lazy var formAdress:  SCFormItem = SCFormItem(formType: .area, formName: "Alamat", placeholder: "contoh: Jalan Ikan Hiu 33")
    lazy var formNumberPhone:  SCFormItem = SCFormItem(formType: .normal, formName: "No Handphone", placeholder: "contoh: +628123456789")
    
    
    lazy var saveButton: SCButton = SCButton(style: .primary, size: .normal, type: .defaultButton, title: "Simpan")
    
    lazy var imagePicker: SCImagePicker = SCImagePicker(
            delegate: self,
            style: .style1,
            completionHandler: { (image) in print("image:", image)}
    )
    
    lazy var formItemStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            formName,
            formCity,
            formAdress,
            formNumberPhone,
            saveButton
        ])
        stackView.setCustomSpacing(16, after: formName)
        stackView.setCustomSpacing(16, after: formCity)
        stackView.setCustomSpacing(16, after: formAdress)
        stackView.setCustomSpacing(24, after: formNumberPhone)
        stackView.axis = .vertical
        return stackView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lengkapi Info Akun"
        formCity.dataList = ["Bandung","Jakarta","Surabaya","Denpasar","Cilegon","Serang","Serang","Yogyakarta","Gorontalo","Cirebon"]
        view.backgroundColor = .white
        view.addSubview(imagePicker)
        view.addSubview(formItemStack)
        
        imagePicker.translatesAutoresizingMaskIntoConstraints = false
        formItemStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            imagePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            imagePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePicker.heightAnchor.constraint(equalToConstant: 100),
            imagePicker.widthAnchor.constraint(equalToConstant: 100),
            
            formItemStack.topAnchor.constraint(equalTo: imagePicker.bottomAnchor, constant: 50),
            formItemStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formItemStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
    }
    
    @objc
    func backButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
