//
//  SCButton.swift
//  SecondHands
//
//  Created by Tatang Sulaeman on 14/06/22.
//

import UIKit

class SCButton: UIButton {
    
    enum Style {
        case primary
        case secondary
    }
    
    enum Size {
        case normal
        case small
    }
    
    enum typeButton {
        case defaultButton
        case disableButton
        case ghostButton
    }
    
    
    public private(set) var style: Style
    public private(set) var size: Size
    public private(set) var type: typeButton
    public private(set) var title: String

    
    //MARK: -init
    init(style: Style, size: Size, type: typeButton, title: String) {
        self.size = size
        self.style = style
        self.type = type
        self.title = title

        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: -method
    private func setup(){
        layer.cornerRadius = 16
        buttonSetup()
        handleSizeButton()
        handleStyleButton()
        
        
    }
    
    private func buttonSetup(){
        setTitle(title, for: .normal)

        titleLabel?.font = UIFont(name: "Poppins-Bold", size: 14)
    }
    
    
    private func handleSizeButton(){
        switch size {
        case .normal:
            frame = CGRect(x: 100, y: 100, width: 200, height: 48)
        case .small:
            frame = CGRect(x: 100, y: 100, width: 200, height: 36)

        }
    }
    
    private func handleStyleButton(){
        switch style {
        case .primary:
            switch type {
            case .defaultButton:
                setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                layer.backgroundColor = UIColor(red: 0.443, green: 0.149, blue: 0.71, alpha: 1).cgColor
            case .disableButton:
                setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                layer.backgroundColor = UIColor(red: 0.816, green: 0.816, blue: 0.816, alpha: 1).cgColor
            case .ghostButton:
                setTitleColor(UIColor(red: 0.443, green: 0.149, blue: 0.71, alpha: 1), for: .normal)
            }
        case .secondary:
            switch type {
            case .defaultButton:
                setTitleColor(UIColor(red: 0.082, green: 0.082, blue: 0.082, alpha: 1), for: .normal)
                layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                layer.borderWidth = 1
                layer.borderColor = UIColor(red: 0.443, green: 0.149, blue: 0.71, alpha: 1).cgColor
            case .disableButton:
                setTitleColor(UIColor(red: 0.816, green: 0.816, blue: 0.816, alpha: 1), for: .normal)
                layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                layer.borderWidth = 1
                layer.borderColor = UIColor(red: 0.816, green: 0.816, blue: 0.816, alpha: 1).cgColor
            case .ghostButton:
                setTitleColor(UIColor(red: 0.082, green: 0.082, blue: 0.082, alpha: 1), for: .normal)
            }
        }
    }
}
