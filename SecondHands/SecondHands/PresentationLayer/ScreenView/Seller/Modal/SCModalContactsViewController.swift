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
    
    let defaultHeight: CGFloat = 438
    let dismissibleHeight: CGFloat = 200
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    
    var currentContainerHeight: CGFloat = 438
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    // Content
    
    //card
    lazy var cardTitleLabel:SCLabel = SCLabel( weight: .medium, size: 14)
    //card
    lazy var titleLabel: SCLabel = SCLabel( weight: .medium, size: 14)
    lazy var bodyLabel: SCLabel = SCLabel( weight: .regular, size: 14)
    lazy var contactsButton: SCButton = SCButton(style: .primary, size: .normal, type: .defaultButton, title: "Hubungi Via Whatsapp")
    
    lazy var containerModalStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [
       titleLabel,
       bodyLabel,
       contactsButton
       ])
        stack.setCustomSpacing(8, after: titleLabel)
        stack.setCustomSpacing(16, after: bodyLabel)
        stack.axis = .vertical
        return stack
    }()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Yeay kamu berhasil mendapat harga yang sesuai"
        bodyLabel.text = "Segera hubungi pembeli melalui whatsapp untuk transaksi selanjutnya"
        
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        containerView.addSubview(containerModalStack)
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
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
            self.view.layoutIfNeeded()
        }
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
    func setupConstraints() {
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerModalStack.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
                dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
 
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                containerModalStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 38),
                containerModalStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                containerModalStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
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
