//
//  SCAccountViewController.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 19/06/22.
//

import UIKit

struct SettingItem {
    let icon: String
    let title: String
}

class SCAccountViewController: UIViewController {
    lazy var imagePicker: SCImagePicker = {
        var imagePicker = SCImagePicker(delegate: self,
                                        style: .style1, completionHandler: { image in
                                            print(image.images)
                                        })
        return imagePicker
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    struct Item {
        let title: String
        let image: Profile
        let setting: [Section]
    }
    
    struct Section {
        let titleFooter: String
        let settingItem: [SettingItem]
    }
    
    struct Profile {
        let imageProfile: String
    }
    
    
    var sectionItem: Section = Section(titleFooter: "Version 1.0.0", settingItem: [
        SettingItem(icon: "pen", title: "Ubah Akun"),
        SettingItem(icon: "gear", title: "Pengaturan Akun"),
        SettingItem(icon: "exit", title: "Keluar")
    ])
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
    }
    
    lazy var textTitle: UILabel = {
        var textTitle = UILabel()
        textTitle.text = "Akun Saya"
        textTitle.font = SCLabel(frame: .zero, weight: .bold, size: 20).font
        textTitle.textColor = .black
        return textTitle
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubview()
        registerTableView()
        setupConstraint()
        
    }
    
    func addSubview() {
        view.addSubview(imagePicker)
        view.addSubview(textTitle)
        view.addSubview(tableView)
    }
    
    func registerTableView() {
        tableView.register(SCAccountTableViewCell.self, forCellReuseIdentifier: SCAccountTableViewCell.reuseIdentifier)
        tableView.register(SCFooterForVersion.self, forHeaderFooterViewReuseIdentifier: SCFooterForVersion.reuseIdentifier)
    }
    
    func setupConstraint() {
        imagePicker.translatesAutoresizingMaskIntoConstraints = false
        textTitle.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            imagePicker.topAnchor.constraint(equalTo: textTitle.bottomAnchor, constant: 24),
            imagePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePicker.heightAnchor.constraint(equalToConstant: 100),
            imagePicker.widthAnchor.constraint(equalToConstant: 100),
            
            tableView.topAnchor.constraint(equalTo: imagePicker.bottomAnchor, constant: 32),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension SCAccountViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionItem.settingItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let settingListCell = tableView.dequeueReusableCell(withIdentifier: SCAccountTableViewCell.reuseIdentifier, for: indexPath) as? SCAccountTableViewCell
        else { return UITableViewCell() }
        
        settingListCell.configure(item: sectionItem.settingItem[indexPath.row])
        settingListCell.selectionStyle = .none
        return settingListCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SCAccountTableViewCell else { return }
        print(sectionItem.settingItem[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard
            let version = tableView.dequeueReusableHeaderFooterView(withIdentifier: SCFooterForVersion.reuseIdentifier) as? SCFooterForVersion
        else { return UIView() }
        version.footerTitle.text = sectionItem.titleFooter
        version.backgroundConfiguration = .clear()
        return version
    }
}
