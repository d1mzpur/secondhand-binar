//
//  SCTextfieldarea.swift
//  SecondHands
//
//  Created by Dimas Purnomo on 17/06/22.
//

import UIKit


class SCTextfieldarea: UITextView {
    var textPadding = UIEdgeInsets(
        top: 0,
        left: 20,
        bottom: 0,
        right: 20
    )
    
    init(frame: CGRect) {
        super.init(frame: frame, textContainer: .none)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "Poppins-Regular", size: 14)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.cornerRadius = 16
        clipsToBounds = true
        backgroundColor = .systemBackground
        isEditable = true
        
    }
    
    public func setText(placeholder: String) {
        self.text = placeholder
    }
    
}
