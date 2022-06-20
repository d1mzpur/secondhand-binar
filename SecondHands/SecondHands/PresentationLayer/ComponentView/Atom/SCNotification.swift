//
//  SCNotification.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 17/06/22.
//

import UIKit

//class SCNotification: UIView {
//    lazy var containerViewNotification: UIView = {
//        var notification = UIView()
//        notification.backgroundColor = UIColor(red: 0.451, green: 0.792, blue: 0.361, alpha: 1)
//        notification.layer.opacity = 0
//        notification.layer.cornerRadius = 12
//        notification.clipsToBounds = true
//        notification.isUserInteractionEnabled = true
//        let swipeupGesture = UISwipeGestureRecognizer(target: self, action: #selector(closeNotification))
//        swipeupGesture.direction = .up
//        notification.addGestureRecognizer(swipeupGesture)
//        return notification
//    }()
//    
//    lazy var textTitle: UILabel = {
//        var textTitle = UILabel()
//        textTitle.font = .systemFont(ofSize: 16, weight: .medium)
//        textTitle.textColor = .white
//        textTitle.text = "Product successfully published"
//        return textTitle
//    }()
//    
//    lazy var imageClose: UIImageView = {
//        var imageClose = UIImageView()
//        imageClose.image = UIImage(systemName: "xmark")
//        imageClose.tintColor = .white
//        imageClose.contentMode = .scaleAspectFit
//        imageClose.clipsToBounds = true
//        imageClose.isUserInteractionEnabled = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeNotification))
//        imageClose.gestureRecognizers = [tapGesture]
//        imageClose.heightAnchor.constraint(equalToConstant: 24).isActive = true
//        return imageClose
//    }()
//    
//    lazy var notificationSV: UIStackView = {
//        var notif = UIStackView(arrangedSubviews: [textTitle, imageClose])
//        notif.axis = .horizontal
//        notif.distribution = .equalSpacing
//        return notif
//    }()
//    
//    var topConstraint: NSLayoutConstraint?
//    
//    var isClicked: Bool = false
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.addSubview(notificationSV)
//        setConstraintToContainer()
//    }
//    
//    @objc func closeNotification(gesture: UIGestureRecognizer) {
//        guard let swipeGesture = gesture as? UISwipeGestureRecognizer else { return }
//        switch swipeGesture.direction {
//        case .right:
//            print("Swiped right")
//        case .down:
//            print("Swiped down")
//        case .left:
//            print("Swiped left")
//        case .up:
//            print("Swiped up")
//        default:
//            break
//        }
//    }
//    
//    func toAnimate(setToNavBar: UINavigationBar?, duration: TimeInterval?, from: CGFloat? = 0, top: CGFloat? = 0) {
//        isClicked.toggle()
//        
//        if isClicked {
//            UIView.animate(withDuration: duration ?? 0, delay: 0, options: .curveEaseInOut) {
//                self.topConstraint?.constant = top ?? 0
//                self.layer.opacity = 1
//                setToNavBar?.layoutIfNeeded()
//            } completion: { (status) in }
//        } else {
//            UIView.animate(withDuration: 0.4) {
//                self.topConstraint?.constant = from ?? 0
//                self.layer.opacity = 0
//                setToNavBar?.layoutIfNeeded()
//            } completion: { (status) in }
//        }
//        
////        topConstraint = self.topAnchor.constraint(equalTo: setToNavBar?.bottomAnchor ?? NSLayoutYAxisAnchor(), constant: 0)
////        topConstraint?.isActive = true
////        self.translatesAutoresizingMaskIntoConstraints = false
////        self.leadingAnchor.constraint(equalTo: setToNavBar?.leadingAnchor ?? NSLayoutXAxisAnchor(), constant: 16).isActive = true
////        self.trailingAnchor.constraint(equalTo: setToNavBar?.trailingAnchor ?? NSLayoutXAxisAnchor(), constant: -16).isActive = true
//        
//        
//        
//    }
//    
//    private func setConstraintToContainer() {
//        self.backgroundColor = .red
//        
//        notificationSV.translatesAutoresizingMaskIntoConstraints = false
//        
//        notificationSV.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
//        notificationSV.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
//        notificationSV.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
//        notificationSV.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
