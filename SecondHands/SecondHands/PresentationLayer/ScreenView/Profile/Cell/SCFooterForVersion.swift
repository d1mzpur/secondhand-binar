//
//  SCFooterForVersion.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 20/06/22.
//

import UIKit

class SCFooterForVersion: UITableViewHeaderFooterView {
    static let reuseIdentifier = "footerVersion"
    lazy var footerTitle: UILabel = {
        var footerTitle = UILabel()
        footerTitle.font = SCLabel(frame: .zero, weight: .regular, size: 12).font
        footerTitle.textColor = .Neutral03
        return footerTitle
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubview(footerTitle)
        setupConstraint()
    }
    
    
    private func setupConstraint() {
        footerTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            footerTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            footerTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            footerTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
