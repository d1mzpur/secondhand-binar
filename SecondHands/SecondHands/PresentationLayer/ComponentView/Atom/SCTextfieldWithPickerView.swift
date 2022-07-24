//
//  SCTextfieldWithPickerView.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 6/20/22.
//

import UIKit

class SCTextfieldWithPickerView: UITextField{
    var dataList: [String] = []
    
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
        createPickerView()
        dismissPickerView()
        font = UIFont(name: "Poppins-Regular", size: 14)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.Neutral02.cgColor
        layer.cornerRadius = 16
        clipsToBounds = true
        backgroundColor = .systemBackground
        clearButtonMode = .never
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        rightView = button
        rightViewMode = .always
    }
    
    public func setPlaceholder(placeholder: String) {
        self.placeholder = placeholder
    }
}

extension SCTextfieldWithPickerView: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row] // dropdown item
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text = dataList[row] // selected item
        
    }

        
    func createPickerView() {
       let pickerView = UIPickerView()
       pickerView.delegate = self
       self.inputView = pickerView
    }
        
    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       self.inputAccessoryView = toolBar
    }
        
    @objc func doneAction() {
          self.endEditing(true)
    }
}
