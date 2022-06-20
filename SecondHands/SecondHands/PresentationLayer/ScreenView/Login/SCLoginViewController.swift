//
//  SCLoginViewController.swift
//  SecondHands
//
//  Created by APPLE on 18/06/22.
//

import UIKit

class SCLoginViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.black
        let image = UIImage(systemName: "arrow.left")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action:  Selector(("action")))

    }
    
    lazy var labelMasuk = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        labelMasuk.font = SCLabel(frame: CGRect(x: 0, y: 0, width: 83, height: 36), weight: .bold, size: 24).font
        labelMasuk.text = "Masuk"
    }
    
    lazy var formEmail: SCFormItem = SCFormItem(formType: .normal, formName: "E-mail", placeholder: "Contoh: johndee@gmail.com")
    
    lazy var formPassword: SCFormItem = SCFormItem(formType: .password, formName: "Password", placeholder: "Masukkan password")
    
    lazy var loginButton = SCButton = SCButton(style: .primary, size: .normal, type: .defaultButton, title: "Masuk")
    
    
    lazy var formItemStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            labelMasuk,
            formEmail,
            formPassword,
            loginButton
            ])
        stackView.setCustomSpacing(24, after: labelMasuk)
        stackView.setCustomSpacing(16, after: formEmail)
        stackView.setCustomSpacing(24, after: formPassword)
        stackView.axis = .vertical
        return stackView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(formItemStack)
        
        formItemStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            formItemStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            formItemStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formItemStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
            ])
    }
    
    
    
}

