//
//  SCProfilViewController.swift
//  SecondHands
//
//  Created by Dimas Purnomo on 18/06/22.
//

import UIKit

class SCProfilViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.black
        let image = UIImage(systemName: "arrow.left")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action:  Selector(("action")))
    }
    
    
    lazy var formName:  SCFormItem = SCFormItem(formType: .normal, formName: "Nama", placeholder: "contoh: johndee@gmail.com")
    lazy var formNumberPhone:  SCFormItem = SCFormItem(formType: .normal, formName: "No Handphone", placeholder: "contoh: +628123456789")
    lazy var formAdress:  SCFormItem = SCFormItem(formType: .area, formName: "Alamat", placeholder: "contoh: Jalan Ikan Hiu 33")
    
    lazy var imagePicker: SCImagePicker = SCImagePicker(
            frame: CGRect(x: 100, y:100, width: 100, height: 100),
            delegate: self,
            style: .style1,
            completionHandler: { (image) in print("image:", image)}
    )
    
    lazy var formItemStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imagePicker,
            formName,
            formAdress,
            formNumberPhone
        ])
        
        stackView.setCustomSpacing(124, after: imagePicker)
        stackView.setCustomSpacing(16, after: formName)
        stackView.setCustomSpacing(16, after: formAdress)
        stackView.axis = .vertical
        return stackView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lengkapi Info Akun"
        view.backgroundColor = .white
        view.addSubview(formItemStack)
        formItemStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            formItemStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formItemStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            formItemStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        ])
    }
    
    
}
