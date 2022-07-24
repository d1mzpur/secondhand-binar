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
    let userDefault = UserDefaults.standard
    lazy var imagePicker: SCImagePicker = {
        var imagePicker = SCImagePicker(delegate: self,
                                        style: .style1, completionHandler: { image in
                                            print(image.images)
                                        })
        imagePicker.disableAction()
        return imagePicker
    }()
    
    lazy var inisialName: UILabel = {
       var inisialName = UILabel()
        inisialName.font = SCLabel(frame: .zero, weight: .bold, size: 32).font
        inisialName.textColor = .DarkBlue04
        inisialName.textAlignment = .center
        return inisialName
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
        updateData()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
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
        updateData()
        setupConstraint()
        
    }
    
    func updateData() {
        NetworkServices().getUserAlamofire { [weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if result.image == nil {
                    self.imagePicker.pickerIcon.isHidden = true
                    self.inisialName.text = result.fullName!.initials
                    self.inisialName.isHidden = false
                } else {
                    self.inisialName.isHidden = true
                    self.imagePicker.changeImage(imageName: result.image ?? "")
                }
            }
        }
    }
    
    func addSubview() {
        view.addSubview(imagePicker)
        view.addSubview(textTitle)
        view.addSubview(tableView)
        self.imagePicker.addSubview(inisialName)
    }
    
    func registerTableView() {
        tableView.register(SCAccountTableViewCell.self, forCellReuseIdentifier: SCAccountTableViewCell.reuseIdentifier)
        tableView.register(SCFooterForVersion.self, forHeaderFooterViewReuseIdentifier: SCFooterForVersion.reuseIdentifier)
    }
    
    func setupConstraint() {
        imagePicker.translatesAutoresizingMaskIntoConstraints = false
        textTitle.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        inisialName.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            inisialName.centerYAnchor.constraint(equalTo: imagePicker.centerYAnchor),
//            inisialName.centerXAnchor.constraint(equalTo: imagePicker.centerXAnchor),
            inisialName.leadingAnchor.constraint(equalTo: imagePicker.leadingAnchor),
            inisialName.trailingAnchor.constraint(equalTo: imagePicker.trailingAnchor),
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
        guard let _ = tableView.cellForRow(at: indexPath) as? SCAccountTableViewCell else { return }
        switch(sectionItem.settingItem[indexPath.row].title){
        case "Ubah Akun":
            let profileVC = SCProfilViewController()
            navigationController?.pushViewController(profileVC, animated: true)
        case "Keluar":
            self.userDefault.removeObject(forKey: "accessToken")
            self.tabBarController?.selectedIndex = 0
            self.tabBarController?.viewWillAppear(true)
        default:
            break;
        }

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
