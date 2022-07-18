//
//  SCRadioButton.swift
//  SecondHands
//
//  Created by Tatang Sulaeman on 05/07/22.
//

import UIKit

class SCRadioButton: UIButton {
    
    enum Style {
        case selected
        case unselected
    }
    
    public private(set) var style: Style
    
    init(style: Style) {
        self.style = style
        
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup(){
        buttonSetup()
        handleStyleButton()
    }
    
    private func buttonSetup(){
        setTitle("", for: .normal)
    }
    
    private func handleStyleButton(){
        switch style {
        case .selected:
            setImage(UIImage(named: "selected.png")?.resizeImageTo(size: CGSize(width: 16, height: 16)), for: .normal)
            
        case .unselected:
            setImage(UIImage(named: "unselected.png")?.resizeImageTo(size: CGSize(width: 16, height: 16)), for: .normal)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
