//
//  SCTestViewController.swift
//  SecondHands
//
//  Created by Tatang Sulaeman on 27/06/22.
//

import UIKit

class SCTestViewController: UIViewController {

    // 1. Defined UI views
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Test Modal"
            label.font = .boldSystemFont(ofSize: 32)
            return label
        }()
        
        lazy var textView: UITextView = {
            let textView = UITextView(frame: .zero)
            textView.font = UIFont.systemFont(ofSize: 16)
            textView.isEditable = false
            textView.text = "Mencoba test modal "
            return textView
        }()
        
    lazy var registerButton: SCButton = SCButton(style: .primary, size: .normal, type: .defaultButton, title: "Register")
        
        lazy var containerStackView: UIStackView = {
            let spacer = UIView()
            let stackView = UIStackView(arrangedSubviews: [titleLabel, textView, spacer, registerButton])
            stackView.axis = .vertical
            stackView.spacing = 16.0
            return stackView
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        registerButton.addTarget(self, action: #selector(presentModalController), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    func setupView() {

        view.backgroundColor = .systemBackground
    }
        
    func setupConstraints() {
        view.addSubview(containerStackView)
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
            
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([

            containerStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
            containerStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -24),
            containerStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            containerStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),

            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    


        @objc func presentModalController() {
            let vc = SCModalContactsViewController()
            vc.modalPresentationStyle = .overCurrentContext
            
            self.present(vc, animated: false)
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
