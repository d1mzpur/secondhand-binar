//
//  SCBuyerModalViewController.swift
//  SecondHands
//
//  Created by Tatang Sulaeman on 18/07/22.
//

import UIKit

class SCBuyerModalViewController: UIViewController {
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
    
    let defaultHeight: CGFloat = 422
    let dismissibleHeight: CGFloat = 200
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    
    var currentContainerHeight: CGFloat = 422
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    //MARK: -Content
    //Content
    lazy var titleModalLabel: SCLabel = {
       let label = SCLabel()
        label.text = "Masukan Harga Tawarmu"
        label.size = 14
        label.weight = .medium
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var bodyLabel: SCLabel = {
       let label = SCLabel()
        label.text = "Harga tawaranmu akan diketahui penual, jika penjual cocok kamu akan segera dihubungi penjual."
        label.size = 14
        label.weight = .regular
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var negoForm: SCFormItem = SCFormItem( formType: .normal, formName: "Harga Tawar", placeholder: "Rp0,00")
    
    lazy var sendButton: SCButton = SCButton(style: .primary, size: .normal, type: .defaultButton, title: "Kirim")
    
    //Card
    lazy var imageProdutc: UIImageView = {
        let imageName = "exampleProductCardImage.png"
        let image = UIImage(named: imageName)?.resizeImageTo(size: CGSize(width: 48, height: 48))
        let imageView = UIImageView(image: image!)
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
//    lazy var
//    //Card
    lazy var productCard = SCBuyerModalCard(frame: .zero, imageProduct: "", productName: "Jam Tangan Casio", productPrice: "Rp250.000")
//    //Content
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        containerView.addSubview(titleModalLabel)
        containerView.addSubview(bodyLabel)
        containerView.addSubview(productCard)
        containerView.addSubview(negoForm)
        containerView.addSubview(sendButton)
        
        
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
            if newHeight < maximumContainerHeight {
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
        titleModalLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        productCard.translatesAutoresizingMaskIntoConstraints = false
        negoForm.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
//        containerModalStack.translatesAutoresizingMaskIntoConstraints = false
        
       
            NSLayoutConstraint.activate([
                dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
                dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
 
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                titleModalLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                titleModalLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                titleModalLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
                
                bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                bodyLabel.topAnchor.constraint(equalTo: titleModalLabel.bottomAnchor, constant: 16),
                
                productCard.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 16),
                productCard.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                productCard.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                
                
                
                negoForm.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                negoForm.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                negoForm.topAnchor.constraint(equalTo: productCard.bottomAnchor, constant: 16),
                
                
                sendButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                sendButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                sendButton.topAnchor.constraint(equalTo: negoForm.bottomAnchor, constant: 16)
                
                
                
                
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
