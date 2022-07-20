//
//  SCImagePicker.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 6/17/22.
//

import UIKit

class SCImagePicker: UIView {
    enum Style: Int {
        case style1 = 1
        case style2 = 2
    }
    
    var style: Style = .style1
    var delegate: UIViewController = UIViewController()
    var handler: (UIImage) -> Void = {arg in }
    var action: Bool = true
    var isContainImage: Bool = false
    
    func disableAction(){
        action = false
    }
    
    lazy var pickerIcon: UIImageView = {
        let image = UIImage(systemName: "camera")
        let imageView = UIImageView(image: image!)
        imageView.tintColor = .DarkBlue04
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(frame: CGRect = CGRect.zero,
         delegate: UIViewController = UIViewController(),
         style: Style = .style1,
         completionHandler: @escaping ( (UIImage) -> Void) )
    {
        super.init(frame: frame)
        self.delegate = delegate
        self.style = style
        self.handler = completionHandler
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // This will call `awakeFromNib` in your code
        setup()
    }
    
    override func layoutSubviews() {
        if (style == .style2){
            if(!isContainImage){
                self.addDashedBorder()
            }
            else{
                self.layer.sublayers?.popLast()
                self.layer.sublayers?.popLast()
            }
        }
        
        
    }
    

    private func setup() {
        self.backgroundColor = .DarkBlue01
        self.layer.cornerRadius = 10
        if (style == .style2){
            self.backgroundColor = .white
            pickerIcon.image = UIImage(systemName: "plus")
            pickerIcon.tintColor = .Neutral03
            
        }
        self.addSubview(pickerIcon)
        self.addAction(#selector(addPhotoAction), target: self)
        NSLayoutConstraint.activate([
            pickerIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pickerIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
    }
}

extension SCImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @objc func addPhotoAction(_ sender: Any) {
        if (action){
            let imagePickerVC = UIImagePickerController()
            imagePickerVC.sourceType = .photoLibrary
            imagePickerVC.delegate = self // new
            delegate.present(imagePickerVC, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            isContainImage = true
            handler(image)
            
            pickerIcon.image = image.resizeImageTo(size: CGSize( width:self.frame.size.width, height: self.frame.size.height))
            pickerIcon.layer.cornerRadius = 10
            pickerIcon.layer.masksToBounds = true
        }
    }
}
