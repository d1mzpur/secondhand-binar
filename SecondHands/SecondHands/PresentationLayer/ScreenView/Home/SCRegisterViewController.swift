//
//  SCRegisterViewController.swift
//  SecondHands
//
//  Created by Tatang Sulaeman on 20/06/22.
//

import UIKit

class SCRegisterViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.black
        let icon = UIImage(systemName: "arrow.left")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: Selector(("action")))
    }
    lazy var registerLabel: SCLabel = SCLabel( weight: .bold, size: 24)
    
    lazy var formName: SCFormItem = SCFormItem(formType: .normal, formName: "Nama", placeholder: "Nama Lengkap")
    
    lazy var formEmail: SCFormItem = SCFormItem(formType: .normal, formName: "Email", placeholder: "contoh: johndee@gmail.com")
    
    lazy var formPassword: SCFormItem = SCFormItem( formType: .password, formName: "Buat password", placeholder: "Buat password")
    
    lazy var registerButton: SCButton = SCButton(style: .primary, size: .normal, type: .defaultButton, title: "Daftar")
    
    lazy var logilLabel: SCLabel = SCLabel( weight: .regular, size: 14)
    
    lazy var loginButton: SCButton = SCButton(style: .primary, size: .small, type: .ghostButton, title: "Masuk disini")
    
    
    
    lazy var formStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
        formName,
        formEmail,
        formPassword,
        registerButton])
        stack.setCustomSpacing(16, after: formName)
        stack.setCustomSpacing(16, after: formEmail)
        stack.setCustomSpacing(24, after: formPassword)
        stack.axis = .vertical
        
        return stack
    }()
    
    lazy var loginLabelStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [
       logilLabel,
       loginButton
       ])
        stack.setCustomSpacing(8, after: logilLabel)
        stack.axis = .horizontal
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(registerLabel)
        registerLabel.text = "Daftar"
        registerLabel.textColor = .black
        logilLabel.text = "Sudah punya akun?"
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
            
            loginLabelStack.topAnchor.constraint(equalTo: formStack.bottomAnchor, constant: 116),
            loginLabelStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
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

}