//
//  SCLoginViewControllers.swift
//  SecondHands
//
//  Created by Dimas Purnomo on 20/06/22.
//

import UIKit

class SCLoginViewControllers: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.barTintColor = .white
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.black
        let image = UIImage(systemName: "arrow.left")
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action:  Selector(("action")))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action:  #selector(backButton))
    }
    
    lazy var registerLabel: SCLabel = SCLabel( weight: .bold, size: 24)
    
    lazy var formEmail: SCFormItem = SCFormItem(formType: .normal, formName: "Email", placeholder: "contoh: johndee@gmail.com")
    
    lazy var formPassword: SCFormItem = SCFormItem( formType: .password, formName: "Password", placeholder: "Masukkkan password")
    
    lazy var loginButton: SCButton = SCButton(style: .primary, size: .normal, type: .defaultButton, title: "Masuk")
    
    lazy var loginLabel: SCLabel = SCLabel( weight: .regular, size: 14)
    
    lazy var registerButton: SCButton = SCButton(style: .primary, size: .small, type: .ghostButton, title: "Daftar disini")
    
    
    
    lazy var formStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
        formEmail,
        formPassword,
        loginButton])

        stack.setCustomSpacing(16, after: formEmail)
        stack.setCustomSpacing(24, after: formPassword)
        stack.axis = .vertical
        
        return stack
    }()
    
    lazy var loginLabelStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [
       loginLabel,
       registerButton
       ])
        stack.setCustomSpacing(8, after: loginLabel)
        stack.axis = .horizontal
        return stack
    }()
    
    @objc func navigateToHome(){
        let tabBar = SCTabBar()
        navigationController?.pushViewController(tabBar, animated: true)
    }
    
    @objc func navigateToRegister(){
        let registerVC = SCRegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(registerLabel)
        registerLabel.text = "Masuk"
        registerLabel.textColor = .black
        loginLabel.text = "Belum punya akun?"
        loginButton.addTarget(self, action: #selector(navigateToHome), for: .touchUpInside )
        registerButton.addTarget(self, action: #selector(navigateToRegister), for: .touchUpInside )
        
        view.addSubview(formStack)
        view.addSubview(loginLabelStack)
        
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        formStack.translatesAutoresizingMaskIntoConstraints = false
        loginLabelStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            registerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 106),
            registerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            registerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            
            formStack.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 24),
            formStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginLabelStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            loginLabelStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    @objc
    func backButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
