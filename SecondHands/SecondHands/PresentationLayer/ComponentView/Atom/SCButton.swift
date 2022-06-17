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
            self.addConstraint(self.heightAnchor.constraint(equalToConstant: 48))
        case .small:
            self.addConstraint(self.heightAnchor.constraint(equalToConstant: 36))

        }
    }
    
    private func handleStyleButton(){
        switch style {
        case .primary:
            switch type {
            case .defaultButton:
                setTitleColor(UIColor.Neutral01, for: .normal)
                layer.backgroundColor = UIColor.DarkBlue04.cgColor
            case .disableButton:
                setTitleColor(UIColor.Neutral01, for: .normal)
                layer.backgroundColor = UIColor.Neutral02.cgColor
            case .ghostButton:
                setTitleColor(UIColor.DarkBlue04, for: .normal)
            }
        case .secondary:
            switch type {
            case .defaultButton:
                setTitleColor(UIColor.Neutral05, for: .normal)
                layer.backgroundColor = UIColor.Neutral01.cgColor
                layer.borderWidth = 1
                layer.borderColor = UIColor.DarkBlue04.cgColor
            case .disableButton:
                setTitleColor(UIColor.Neutral02, for: .normal)
                layer.backgroundColor = UIColor.Neutral01.cgColor
                layer.borderWidth = 1
                layer.borderColor = UIColor.Neutral02.cgColor
            case .ghostButton:
                setTitleColor(UIColor.Neutral05, for: .normal)
            }
        }
    }
}
