//
//  SCLoginViewController.swift
//  SecondHands
//
//  Created by APPLE on 20/06/22.
//

import UIKit

class SCLoginViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.black
        let image = UIImage(systemName: "arrow.left")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action:  Selector(("action")))

    }
    
    lazy var formEmail: SCFormItem = SCFormItem(formType: .normal, formName: "E-mail", placeholder: "Contoh: johndee@gmail.com")
    
    lazy var formPassword: SCFormItem = SCFormItem(formType: .password, formName: "Password", placeholder: "Masukkan password")
    
    lazy var loginButton = SCButton = SCButton(style: .primary, size: .normal, type: .defaultButton, title: "Masuk")
    
    
    lazy var formItemStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            formEmail,
            formPassword,
            formNumberPhone,
            loginButton
            ])
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

