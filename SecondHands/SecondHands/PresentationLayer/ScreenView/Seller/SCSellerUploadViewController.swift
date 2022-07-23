//
//  SCSellerUploadViewController.swift
//  SecondHands
//
//  Created by Tatang Sulaeman on 21/06/22.
//

import UIKit

class SCSellerUploadViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.barTintColor = .white
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.black
        let image = UIImage(systemName: "arrow.left")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButton))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    var category: [Categories] = []{
        didSet{
            var temp: [String] = []
            category.forEach{ item in
                temp.append( item.name ?? "" )
            }
            self.formCategory.dataList = temp
        }
    }
    var categoryId: Int = 0 
    
    var image: UIImage = UIImage()
    
    lazy var formProductName: SCFormItem = SCFormItem( formType: .normal, formName: "Nama Produk", placeholder: "Nama Produk")
    
    lazy var formProductPrice: SCFormItem = SCFormItem(formType: .normal, formName: "Harga Produk", placeholder: "Rp.0.00")
    
    lazy var formCategory: SCFormItem = SCFormItem(formType: .pickerView, formName: "Kategori", placeholder: "Pilih Kategori")
    
    lazy var formDescription: SCFormItem = SCFormItem(formType: .area, formName: "Deskripsi", placeholder: "")
    
    lazy var labelImagePicker: SCLabel = SCLabel(weight: .regular, size: 14)
    
    lazy var imagePickerProduct: SCImagePicker = SCImagePicker(delegate: self, style: .style2, completionHandler: { (image) in self.image = image})
    
    lazy var previewButton: SCButton = SCButton(style: .secondary, size: .normal, type: .defaultButton, title: "Preview")
    
    lazy var uploadButton: SCButton = SCButton(style: .primary, size: .normal, type: .defaultButton, title: "Terbitkan")
    
    lazy var formStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [
       formProductName,
       formProductPrice,
       formCategory,
       formDescription,
       ])
        stack.setCustomSpacing(16, after: formProductName)
        stack.setCustomSpacing(16, after: formProductPrice)
        stack.setCustomSpacing(16, after: formCategory)
        stack.axis = .vertical
        return stack
    }()
    
    lazy var buttonStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [
       previewButton,
       uploadButton
       ])
        stack.setCustomSpacing(20, after: previewButton)
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    func getCategory() {
        NetworkServices().getCategory { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.category = result
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategory()
        getUser()
        formProductPrice.Textfield.keyboardType = .numberPad
        navigationItem.title = "Lengkapi Detail Produk"
        view.backgroundColor = .white
        labelImagePicker.text = "Foto Produk"
        previewButton.addTarget(self, action: #selector(navigateToPreview), for: .touchUpInside )
        uploadButton.addTarget(self, action: #selector(publishProduct), for: .touchUpInside )
//        imagePickerProduct.layer.borderWidth = 1
        view.addSubview(formStack)
        view.addSubview(labelImagePicker)
        view.addSubview(imagePickerProduct)
        view.addSubview(buttonStack)
        
        formStack.translatesAutoresizingMaskIntoConstraints = false
        labelImagePicker.translatesAutoresizingMaskIntoConstraints = false
        imagePickerProduct.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            formStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 106),
            formStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            labelImagePicker.topAnchor.constraint(equalTo: formStack.bottomAnchor, constant: 16),
            labelImagePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            imagePickerProduct.topAnchor.constraint(equalTo: labelImagePicker.bottomAnchor, constant: 16),
            imagePickerProduct.widthAnchor.constraint(equalToConstant: 96),
            imagePickerProduct.heightAnchor.constraint(equalToConstant: 96),
            imagePickerProduct.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            buttonStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])

        // Do any additional setup after loading the view.
    }
    var user: User = User(imageUser: "", userName: "", city: "")
    func getUser() {
        NetworkServices().getUserAlamofire() { (result) in
            DispatchQueue.main.async {
                let user = User(
                    imageUser: result.image ?? "",
                    userName: result.fullName ?? "",
                    city: result.city ?? "Indonesia"
                )
                self.user = user
            }
        }
    }
    
    func resetForm(){
        formProductName.text.removeAll()
        formProductPrice.text.removeAll()
        formCategory.text.removeAll()
        formDescription.text.removeAll()
        imagePickerProduct.resetImage()
    }
    func postData(){
        NetworkServices().createProduct(
            name: formProductName.text ,
            description: formDescription.text ,
            price: Int(formProductPrice.text) ?? 0,
            category: categoryId,
            location: user.city ,
            image: (imagePickerProduct.pickerIcon.image!.jpegData(compressionQuality: 0.3))!
        ){ (result) in
            switch result {
            case .success(let success):
                print(success)
                self.tabBarController?.selectedIndex = 3
                self.navigationController?.popViewController(animated: false)
            case .failure(let error):
//                let alert = UIAlertController(title: "Pemberitahuan", message: "Gagal membuat product", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                self.present(alert, animated: true)
                print(error)
                return
            }
  
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func backButton() {
        self.tabBarController?.selectedIndex = 3
    }
    
    @objc func publishProduct() {
        if(formProductName.text != "" &&
           formProductPrice.text != "" &&
           formCategory.text != "" &&
           formDescription.text != "" &&
           (imagePickerProduct.pickerIcon.image != nil)
        ){
            let tempCategory = category.filter{
                $0.name == formCategory.text
            }
            categoryId = tempCategory[0].id ?? 0
            self.postData()
            self.resetForm()
            self.tabBarController?.selectedIndex = 3
  
            
        }else{
            let alert = UIAlertController(title: "Pemberitahuan", message: "Lengkapi data terlebih dahulu", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            return
        }
    }
    
    @objc func navigateToPreview(){
    
        if(formProductName.text != "" &&
           formProductPrice.text != "" &&
           formCategory.text != "" &&
           formDescription.text != "" &&
           (imagePickerProduct.pickerIcon.image != nil)
        ){
            let tempCategory = category.filter{
                $0.name == formCategory.text
            }
            categoryId = tempCategory[0].id ?? 0
            let SCSellerPublishVC = SCSellerPublishProductViewController()
            SCSellerPublishVC.uploadViewDelegate = self
            SCSellerPublishVC.productCard.productTitle.text = formProductName.text
            SCSellerPublishVC.productPrice = Int(formProductPrice.text) ?? 0
            SCSellerPublishVC.productCard.productCategory.text = formCategory.text
            SCSellerPublishVC.descCard.descLabel.text = formDescription.text
            SCSellerPublishVC.makeHeaderImageView.image = imagePickerProduct.pickerIcon.image!
            SCSellerPublishVC.sellerCard.configure(user: user)
            navigationController?.pushViewController(SCSellerPublishVC, animated: true)
        }else{
            let alert = UIAlertController(title: "Pemberitahuan", message: "Lengkapi data terlebih dahulu", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            return
        }
//        switch(formProductName.text.isEmpty, formProductPrice.text.isEmpty, formCategory.text.isEmpty, formDescription.text.isEmpty){
//            
//        case (false, false, false, false):
//            let SCSellerPublishVC = SCSellerPublishProductViewController()
//            navigationController?.pushViewController(SCSellerPublishVC, animated: true)
//            SCSellerPublishVC.productCard.productTitle.text = formProductName.text
//            SCSellerPublishVC.productCard.productPrice.text = ("Rp " + formProductPrice.text)
//            SCSellerPublishVC.productCard.productCategory.text = formCategory.text
//            SCSellerPublishVC.descCard.descLabel.text = formDescription.text
//            SCSellerPublishVC.makeHeaderImageView.image = imagePickerProduct.pickerIcon.image!
//            
//        case (true, false, false, false):
//            print("Nama Product kosong")
//            
//        case (false, true, true, true):
//            print("Harga Product kosong")
//            
//        case (false, false, true, true):
//            print("Category kosong")
//            
//        case (false, false, false, true):
//            print("Deskripsi Product kosong")
//            
//        default:
//            print("Data semua product kosong")
//        }
       
    }
}
