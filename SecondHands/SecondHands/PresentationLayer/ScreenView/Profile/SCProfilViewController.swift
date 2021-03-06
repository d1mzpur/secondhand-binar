//
//  SCProfilViewController.swift
//  SecondHands
//
//  Created by Dimas Purnomo on 18/06/22.
//

import UIKit
import Kingfisher

class SCProfilViewController: UIViewController {
    let userDefault = UserDefaults.standard
    var dataUser: UpdateUserModel?
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.barTintColor = .white
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.black
    let image = UIImage(systemName: "arrow.left")
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action:  Selector(("action")))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action:  #selector(backButton))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    
    lazy var formName:  SCFormItem = SCFormItem(formType: .normal, formName: "Nama", placeholder: "contoh: johndee@gmail.com")
    lazy var formCity:  SCFormItem = SCFormItem(formType: .pickerView, formName: "Kota", placeholder: "contoh: Pilih Kota")
    lazy var formAdress:  SCFormItem = SCFormItem(formType: .area, formName: "Alamat", placeholder: "")
    lazy var formNumberPhone:  SCFormItem = SCFormItem(formType: .normal, formName: "No Handphone", placeholder: "contoh: +628123456789")
    
    
    lazy var saveButton: SCButton = {
        let saveButton = SCButton(style: .primary, size: .normal, type: .defaultButton, title: "Simpan")
        saveButton.addTarget(self, action: #selector(updateData), for: .touchUpInside)
        return saveButton
    }()
    
    lazy var imagePicker: SCImagePicker = SCImagePicker(
            delegate: self,
            style: .style1,
            completionHandler: { (image) in
                (self.imagePicker as UIView).changeImage(image: image)
                self.imageData = image.jpegData(compressionQuality: 0.1)
                print(self.imageData)
            }
    )
    
    lazy var imageProfile: UIImageView = {
       var imageProfile = UIImageView()
        imageProfile.clipsToBounds = true
        return imageProfile
    }()
    
    lazy var formItemStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            formName,
            formCity,
            formAdress,
            formNumberPhone,
            saveButton
        ])
        stackView.setCustomSpacing(16, after: formName)
        stackView.setCustomSpacing(16, after: formCity)
        stackView.setCustomSpacing(16, after: formAdress)
        stackView.setCustomSpacing(24, after: formNumberPhone)
        stackView.axis = .vertical
        return stackView
        
    }()
    var imageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lengkapi Info Akun"
        formCity.dataList = ["Bandung","Jakarta","Surabaya","Denpasar","Cilegon","Serang","Yogyakarta","Gorontalo","Cirebon", "Jambi","Bengkulu","Lampung","Riau", "Bogor", "Depok",  "Semarang", "Banyumas","Batu", "Malang", "Madiun", "Banten", "Bali", "Pontianank", "Poso", "Gowa", "Banjar", "Cimahi",  "Bekasi", "Bogor", "Karawang", "Purwakarta", "Tasikmalaya", "Sukabumi", "Kuningan", "Banyumanik", "Magelang", "Salahtiga", "Tegal", "Pemalang", "Kendal", "Demak", "Kudus", "Pati", "Magelang", "Wonosobo", "Gunung Kidul", "Jombang", "Magetan", "Ngawi", "Situbondo"]
        view.backgroundColor = .white
//        getUser()
        getUserAla()
        view.addSubview(imagePicker)
        view.addSubview(formItemStack)
        
        imagePicker.translatesAutoresizingMaskIntoConstraints = false
        formItemStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            imagePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            imagePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePicker.heightAnchor.constraint(equalToConstant: 100),
            imagePicker.widthAnchor.constraint(equalToConstant: 100),
            
            formItemStack.topAnchor.constraint(equalTo: imagePicker.bottomAnchor, constant: 50),
            formItemStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formItemStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
    }
    
    func configure(data: UpdateUserModel) {
        self.formName.Textfield.text = data.fullName
        self.formCity.TextfieldWithPicker.text = data.city
        self.formAdress.Textfieldarea.setText(placeholder: data.address ?? "")
        self.formNumberPhone.Textfield.text = data.phoneNumber
    }
    
    @objc
    func updateData() {
        let formNumber = Int(formNumberPhone.text) ?? 0
//        print("click")
        NetworkServices().updateProfiles(
            image: imageData ?? Data(),
            fullname: formName.text,
            city: formCity.text,
            address: formAdress.text,
            phoneNumber: formNumber
        ) { (result) in
//            print("result success" ,result.image)
            if result {
//                self.configure(data: result)
                let alert = UIAlertController(title: "Profile Updated", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                })
                
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
//        NetworkServices().updateProfile(image: "", fullname: formName.text, city: formCity.text, address: formAdress.text, phoneNumber: formNumber) { [weak self] (result) in
//            guard let self = self else { return }
//            switch result {
//            case .success(let success):
//                DispatchQueue.main.async {
//                    print(success)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
    }
    
    func getUserAla() {
        NetworkServices().getUserAlamofire() { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let image = result.image {
                    (self.imagePicker as UIView).changeImage(imageName: image)
                    let imageContainer = UIImageView()
                    imageContainer.loadImage(resource: image)
                    self.imageData = imageContainer.image?.jpegData(compressionQuality: 0.1)
                    print("SEND IMAGE DATA ==> ", self.imageData)
                }
                
                self.configure(data: result)
            }
        }
    }
    
    @objc
    func backButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
