//
//  SCAccountTableViewCell.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 19/06/22.
//

import UIKit

class SCAccountTableViewCell: UITableViewCell {
    static let reuseIdentifier = "accountCell"
    lazy var iconSetting = UIImageView()
    lazy var titleSetting = UILabel()
    lazy var divider: UIView = {
        var divider = UIView()
        divider.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        return divider
    }()
    lazy var horizontalStackView = UIStackView(arrangedSubviews: [iconSetting, titleSetting, UIView()])
    lazy var verticalStackView = UIStackView(arrangedSubviews: [horizontalStackView, divider])
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        addSubView()
        configureStackView()
        
        setupConstraint()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconSetting.image = nil
        titleSetting.text = nil
    }
    
    func configure(item: SettingItem) {
        iconSetting.image = UIImage(named: item.icon)
        titleSetting.text = item.title
    }
    
    private func configureView() {
        iconSetting.contentMode = .scaleAspectFit
        titleSetting.font = SCLabel(frame: .zero, weight: .medium, size: 14).font
        
    }
    
    private func addSubView() {
        self.addSubview(verticalStackView)
    }
    
    private func configureStackView() {
        horizontalStackView.alignment = .center
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 20
        
//        verticalStackView.alignment = .leading
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 16
    }
    
    private func setupConstraint() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1),
            
            verticalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
