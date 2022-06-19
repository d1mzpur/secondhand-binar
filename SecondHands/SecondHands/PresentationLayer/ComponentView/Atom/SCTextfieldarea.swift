//
//  SCTextfieldarea.swift
//  SecondHands
//
//  Created by Dimas Purnomo on 17/06/22.
//

import UIKit


class SCTextfieldarea: UITextView, UITextViewDelegate {
    var textPadding = UIEdgeInsets(
        top: 15,
        left: 15,
        bottom: 15,
        right: 15
    )
    
    var placeholder: String = "Placeholder"{
        didSet{
            self.text = placeholder
        }
    }
    
    init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame, textContainer: .none)
        self.delegate = self
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.Neutral02 {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = self.placeholder
            textView.textColor = UIColor.Neutral02
        }
    }
    
    private func configure() {
        textContainerInset = textPadding
        font = UIFont(name: "Poppins-Regular", size: 14)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.Neutral02.cgColor
        layer.cornerRadius = 16
        clipsToBounds = true
        backgroundColor = .systemBackground
        isEditable = true
    }
    
    public func setText(placeholder: String) {
        self.placeholder = placeholder
        self.textColor = UIColor.Neutral02
    }
    
}
