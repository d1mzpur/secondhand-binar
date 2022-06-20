//
//  SCTextField.swift
//  SecondHands
//
//  Created by Dimas Purnomo on 15/06/22.
//

import UIKit

class SCTextfield: UITextField {
    var textPadding = UIEdgeInsets(
        top: 0,
        left: 20,
        bottom: 0,
        right: 20
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds)
        return rect.offsetBy(dx: -24, dy: 0)
    }

    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.clearButtonRect(forBounds: bounds)
        return rect.offsetBy(dx: -24, dy: 0)
    }
    
    private func configure() {
        font = UIFont(name: "Poppins-Regular", size: 14)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.Neutral02.cgColor
        layer.cornerRadius = 16
        clipsToBounds = true
        backgroundColor = .systemBackground
        clearButtonMode = .whileEditing
    }
    
    public func setPlaceholder(placeholder: String) {
        self.placeholder = placeholder
    }
    
    public func setForPasswordTextfield() {
        clearButtonMode = .never
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = button
        rightViewMode = .always
    }

    @objc func togglePasswordView(_ sender: UIButton) {
        isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
    
}

//private lazy var areaTextField: SCTextfield = {
//    let textField = SCTextfield()
//    textField.setPlaceholder(placeholder: "Area")
//    textField.setForAreaTextField()
//    return textField
//}()

//view.addSubviews(
//    areaTextField
//)
//
//NSLayoutConstraint.activate([
//
//    areaTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//    areaTextField.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
//    areaTextField.heightAnchor.constraint(equalToConstant: 48),
//
//
//])
