//
//  SCModalTransactionViewController.swift
//  SecondHands
//
//  Created by Tatang Sulaeman on 05/07/22.
//

import UIKit

class SCModalTransactionViewController: UIViewController {
    
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
    
    let defaultHeight: CGFloat = 354
    let dismissibleHeight: CGFloat = 200
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    
    var currentContainerHeight: CGFloat = 354
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    // Content
    lazy var titleLabel: SCLabel = {
       var label = SCLabel()
        label.text = "Perbarui status penjualan produkmu"
        label.weight = .bold
        label.size = 14
        return label
    }()
    lazy var succesSellLabel: SCLabel = {
        var label = SCLabel()
        label.text = "Berhasil Terjual"
        label.size = 14
        label.weight = .medium
        return label
    }()
    lazy var succesSellSecondLabel: SCLabel = {
        var label = SCLabel()
        label.text = "Kamu telah sepakat menjual produk ini kepada pembeli"
        label.size = 14
        label.weight = .regular
        label.numberOfLines = 0
        return label
    }()
    
    lazy var cancelSellLabel: SCLabel = {
        var label = SCLabel()
        label.text = "Batalkan Transaksi"
        label.size = 14
        label.weight = .medium
        return label
    }()
    lazy var cancelSellSecondLabel: SCLabel = {
        var label = SCLabel()
        label.text = "Kamu membatalkan transaksi produk ini dengan pembeli"
        label.size = 14
        label.weight = .regular
        label.tintColor = .DarkBlue01
        label.numberOfLines = 0
        return label
    }()
    
    lazy var radioButtonOne: SCRadioButton = SCRadioButton(style: .selected)
    lazy var radioButtonTwo: SCRadioButton = SCRadioButton(style: .unselected)
    lazy var submitButton: SCButton = SCButton(style: .primary, size: .normal, type: .defaultButton, title: "Kirim")
    lazy var sellTitleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
        radioButtonOne,
        succesSellLabel,
        ])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.setCustomSpacing(19, after: radioButtonOne)
        stack.alignment = .leading
        return stack
    }()
    
    lazy var succesSellStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
        sellTitleStack,
        succesSellSecondLabel,
        ])
        stack.axis = .vertical
        stack.setCustomSpacing(8, after: sellTitleStack)
        return stack
    }()
    
    lazy var cancelTitleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
        radioButtonTwo,
        cancelSellLabel
        ])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.setCustomSpacing(19, after: radioButtonTwo)
        stack.alignment = .leading
        
        return stack
    }()
    
    lazy var cancelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
        cancelTitleStack,
        cancelSellSecondLabel
        ])
        stack.axis = .vertical
        stack.setCustomSpacing(8, after: cancelTitleStack)
        
        return stack
    }()
    
    lazy var containerModalStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [
        titleLabel,
        succesSellStack,
        cancelStack,
        submitButton
        
       ])
        stack.setCustomSpacing(24, after: titleLabel)
        stack.setCustomSpacing(24, after: succesSellStack)
        stack.setCustomSpacing(40, after: cancelStack)
        stack.axis = .vertical
        return stack
    }()
    
    // Content

    override func viewDidLoad() {
        super.viewDidLoad()
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
                containerModalStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                
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
