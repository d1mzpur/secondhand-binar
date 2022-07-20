//
//  SCModalContactsViewController.swift
//  SecondHands
//
//  Created by Tatang Sulaeman on 27/06/22.
//

import UIKit

class SCModalContactsViewController: UIViewController {
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    let defaultHeight: CGFloat = 480
    let dismissibleHeight: CGFloat = 200
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    
    var currentContainerHeight: CGFloat = 480
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    //MARK: -Content
    // Content
    
    //card
    lazy var cardTitleLabel:SCLabel = {
        var label = SCLabel()
        label.weight = .medium
        label.size = 14
        label.text = "Product Match"
        label.textAlignment = .center
        return label
    }()
    
    
    
    lazy var buyerPicture: UIImageView = {
        let imageName = "exampleProductCardImage.png"
        let image = UIImage(named: imageName)?.resizeImageTo(size: CGSize(width: 48, height: 48))
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .left
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    
    lazy var buyerLabel:SCLabel = {
        var label = SCLabel()
        label.weight = .medium
        label.size = 14
        label.text = "Nama Pembeli"
        return label
    }()
    
    lazy var buyerCityLabel:SCLabel = {
        var label = SCLabel()
        label.weight = .medium
        label.size = 10
        label.text = "Kota"
        return label
    }()

    lazy var productPicture: UIImageView = {
        let imageName = "exampleProductCardImage.png"
        let image = UIImage(named: imageName)?.resizeImageTo(size: CGSize(width: 48, height: 48))
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .left
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    
    lazy var productLabel:SCLabel = {
        var label = SCLabel()
        label.weight = .medium
        label.size = 14
        label.text = "Jam Tangan Casio"
        return label
    }()
    
    lazy var productPriceLabel:SCLabel = {
        var label = SCLabel()
        label.weight = .medium
        label.size = 14
        label.text = "Rp250.000"
        return label
    }()
    
    lazy var productPriceNegoLabel:SCLabel = {
        var label = SCLabel()
        label.weight = .medium
        label.size = 14
        label.text = "Ditawar Rp200.000"
        return label
    }()
    

    
    lazy var newView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.dropShadow(type: .low)
        
        view.addSubviews(cardTitleLabel)
        view.addSubviews(buyerPicture)
        view.addSubviews(buyerLabel)
        view.addSubviews(buyerCityLabel)
        view.addSubviews(productPicture)
        view.addSubviews(productLabel)
        view.addSubviews(productPriceLabel)
        view.addSubviews(productPriceNegoLabel)
        
        return view
        
    }()
    
    
    //card
    lazy var titleLabel: SCLabel = SCLabel( weight: .medium, size: 14)
    lazy var bodyLabel: SCLabel = SCLabel( weight: .regular, size: 14)
    lazy var contactsButton: SCButton = SCButton(style: .primary, size: .normal, type: .defaultButton, title: "Hubungi Via Whatsapp")
    
    
    // Content
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Yeay kamu berhasil mendapat harga yang sesuai"
        bodyLabel.text = "Segera hubungi pembeli melalui whatsapp untuk transaksi selanjutnya"
        titleLabel.numberOfLines = 0
        bodyLabel.numberOfLines = 0
        
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(bodyLabel)
        containerView.addSubview(newView)
        containerView.addSubview(contactsButton)
        setupView()
        setupConstraints()
        setupGesture()

        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        view.backgroundColor = .clear
    }
    
    func animatePresentContainer(){
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func animateShowDimmedView(){
        dimmedView.alpha = 0
//        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
            self.view.layoutIfNeeded()
//        }
    }
    
    func animateDismissView() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.view.layoutIfNeeded()
        }
        
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }

    func setupGesture(){
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        gesture.delaysTouchesBegan = false
        gesture.delaysTouchesEnded = false
        view.addGestureRecognizer(gesture)
    }
    
    func animateContainerHeight(_ height:CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }
    
    @objc func handleGesture(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
        print("Pan gesture y offset: \(translation.y)")
        
        let isDragDown = translation.y > 0
        print("Drag Direction: \(isDragDown ? "going down" : "going up")")
        
        let newHeight = currentContainerHeight - translation.y
        
        switch gesture.state {
        case .changed:
            if newHeight < maximumContainerHeight && newHeight > defaultHeight{
                print(newHeight)
                containerViewHeightConstraint?.constant = newHeight
                view.layoutIfNeeded()
            }
            
        case  .ended:
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            }
            
            else if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
            }
            
        default:
            break
        }
        
        
    }
    //MARK: -SetupConstraint
    func setupConstraints() {
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerModalStack.translatesAutoresizingMaskIntoConstraints = false
        
        newView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        cardTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        buyerPicture.translatesAutoresizingMaskIntoConstraints = false
        buyerLabel.translatesAutoresizingMaskIntoConstraints = false
        buyerCityLabel.translatesAutoresizingMaskIntoConstraints = false
        productPicture.translatesAutoresizingMaskIntoConstraints = false
        productLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceNegoLabel.translatesAutoresizingMaskIntoConstraints = false
        contactsButton.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
                dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
 
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
//                containerModalStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 38),
//                containerModalStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
//                containerModalStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                
                
                titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 38),
                titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                
                bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                
                newView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 16),
                newView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                newView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
//                newView.heightAnchor.constraint(equalTo: containerView.height),

                newView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                newView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

                
                cardTitleLabel.topAnchor.constraint(equalTo: newView.topAnchor, constant: 16),
                cardTitleLabel.leadingAnchor.constraint(equalTo: newView.leadingAnchor, constant: 20),
                cardTitleLabel.trailingAnchor.constraint(equalTo: newView.trailingAnchor, constant: -20),
                
                buyerPicture.topAnchor.constraint(equalTo: cardTitleLabel.bottomAnchor, constant: 16),
                buyerPicture.leadingAnchor.constraint(equalTo: newView.leadingAnchor, constant: 20),


                buyerLabel.topAnchor.constraint(equalTo: cardTitleLabel.bottomAnchor, constant: 16),
                buyerLabel.leftAnchor.constraint(equalTo: buyerPicture.rightAnchor, constant: 16),
                
                buyerCityLabel.topAnchor.constraint(equalTo: buyerLabel.bottomAnchor, constant: 4),
                buyerCityLabel.leftAnchor.constraint(equalTo: buyerPicture.rightAnchor, constant: 16),
                
                productPicture.topAnchor.constraint(equalTo: buyerPicture.bottomAnchor, constant: 16),
                productPicture.leadingAnchor.constraint(equalTo: newView.leadingAnchor, constant: 20),
                
                productLabel.topAnchor.constraint(equalTo: buyerCityLabel.bottomAnchor, constant: 16),
                productLabel.leftAnchor.constraint(equalTo: productPicture.rightAnchor, constant: 16),
                
                productPriceLabel.topAnchor.constraint(equalTo: productLabel.bottomAnchor, constant: 4),
                productPriceLabel.leftAnchor.constraint(equalTo: productPicture.rightAnchor, constant: 16),
                
                productPriceNegoLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 4),
                productPriceNegoLabel.leftAnchor.constraint(equalTo: productPicture.rightAnchor, constant: 16),
                
                contactsButton.topAnchor.constraint(equalTo: newView.bottomAnchor, constant: 24),
                contactsButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                contactsButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
                
                
                
                
                
                
                
                
            ])
            

            containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)

            containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)

            containerViewHeightConstraint?.isActive = true
            containerViewBottomConstraint?.isActive = true
        }
    

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
