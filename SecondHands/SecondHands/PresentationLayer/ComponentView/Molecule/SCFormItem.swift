//
//  SCFormItem.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 6/18/22.
//

import UIKit

class SCFormItem: UIView {
    enum FormType {
        case normal
        case password
        case pickerView
        case area
    }
    
    var formType: FormType = .normal
    var formName: String = "Form Name" {
        didSet {
            formLabel.text = formName
        }
    }
    var placeholder: String = "" {
        didSet {
            switch formType{
                case .normal: return Textfield.setPlaceholder(placeholder: placeholder)
                case .password: return TextfieldPassword.setPlaceholder(placeholder: placeholder)
                case .pickerView: return TextfieldWithPicker.setPlaceholder(placeholder: placeholder)
                case .area: return Textfieldarea.setText(placeholder: placeholder)
            }
        }
    }
    
    var text: String {
        get {
            switch formType{
                case .normal: return Textfield.text ?? ""
                case .password: return TextfieldPassword.text ?? ""
                case .pickerView: return TextfieldWithPicker.text ?? ""
                case .area: return Textfieldarea.text
            }
        }
        set {
            switch formType{
            case .normal: return Textfield.text = newValue
                case .password: return TextfieldPassword.text = newValue
                case .pickerView: return TextfieldWithPicker.text = newValue
                case .area: return Textfieldarea.text = newValue
            }
        }
    }
    
    var dataList: [String] = [] {
        didSet{
            if (formType == .pickerView){
                TextfieldWithPicker.dataList = dataList
            }
        }
    }
    
    lazy var formLabel: SCLabel = {
        var lbl = SCLabel(size: 12)
        lbl.textColor = .Neutral05
        return lbl
    }()
    
    lazy var Textfield: SCTextfield = {
        var textField = SCTextfield()
        textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 48))
        return textField
    }()
    
    lazy var TextfieldWithPicker: SCTextfieldWithPickerView = {
        var textField = SCTextfieldWithPickerView()
        textField.dataList = []
        textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 48))
        return textField
    }()
    
    lazy var TextfieldPassword: SCTextfield = {
        var textField = SCTextfield()
        textField.setForPasswordTextfield()
        textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 48))
        return textField
    }()
    
    lazy var Textfieldarea: SCTextfieldarea = {
        var textField = SCTextfieldarea()
        textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 80))
        return textField
    }()
    
    
    lazy var formItemStack: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(formLabel)
        switch formType{
            case .normal: stackView.addArrangedSubview(Textfield)
            case .password: stackView.addArrangedSubview(TextfieldPassword)
            case .pickerView: stackView.addArrangedSubview(TextfieldWithPicker)
            case .area: stackView.addArrangedSubview(Textfieldarea)
        }
        stackView.setCustomSpacing(4.0, after: formLabel)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        setup()
    }
    
    init(frame: CGRect = CGRect.zero, formType: FormType = .normal, formName: String = "Form Name", placeholder: String = "Form Placeholder") {
        super.init(frame: frame)
        self.formType = formType
        defer {
            self.formName = formName
            self.placeholder = placeholder
        }
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // This will call `awakeFromNib` in your code
        setup()
    }
    
    private func setup() {
        self.backgroundColor = .white
        self.addSubview(formItemStack)

        NSLayoutConstraint.activate([
    
            formItemStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            formItemStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            formItemStack.topAnchor.constraint(equalTo: self.topAnchor),
            formItemStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)

        ])
        
    }
}
