//
//  UIView+Extension.swift
//  SecondHands
//
//  Created by Tio Hardadi Somantri on 6/15/22.
//

import UIKit

extension UIView {

    enum ShadowType: CGFloat {
        case low = 2
        case high = 6
    }
        
    func dropShadow(type: ShadowType = .high ) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = type.rawValue
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach{
            addSubview($0)
        }
    }
    
    func setTranslatesAutoresizingMaskIntoConstraintsToFalse(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func addAction(_ selector: Selector, target: AnyObject) {
        isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: target, action: selector)
        self.addGestureRecognizer(gesture)
    }
    
    func addDashedBorder(color: UIColor = UIColor.Neutral02) {

        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath

        self.layer.addSublayer(shapeLayer)
    }
    
    func showLoading(style: UIActivityIndicatorView.Style = .medium) {
        let loading =  UIActivityIndicatorView(style: .medium)
        
        loading.tintColor = .systemBlue
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.startAnimating()
        loading.hidesWhenStopped = true
//        loading.tag = UIView.loadingViewTag
        addSubview(loading)
        loading.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loading.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    func stopLoading() {
        let loading = UIActivityIndicatorView(style: .medium)
        loading.stopAnimating()
        loading.removeFromSuperview()
    }
    
    func addImage(image: String) {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.loadImage(resource: image)

        // you can change the content mode:
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill

        self.addSubview(imageViewBackground)
        self.bringSubviewToFront(imageViewBackground)
    }
    
        func changeImage(imageName: String, contentMode: UIView.ContentMode = .scaleToFill) {
            // setup the UIImageView
            let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
            backgroundImageView.loadImage(resource: imageName)
            backgroundImageView.contentMode = contentMode
            backgroundImageView.clipsToBounds = true
            backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            backgroundImageView.layer.cornerRadius = 10
            addSubview(backgroundImageView)
            bringSubviewToFront(backgroundImageView)

            // adding NSLayoutConstraints
            let leadingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
            let trailingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
            let topConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
            let bottomConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)

            NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        }
    
    func changeImage(image: UIImage, contentMode: UIView.ContentMode = .scaleToFill) {
        // setup the UIImageView
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = image
        backgroundImageView.contentMode = contentMode
        backgroundImageView.clipsToBounds = true
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.layer.cornerRadius = 10
        addSubview(backgroundImageView)
        bringSubviewToFront(backgroundImageView)

        // adding NSLayoutConstraints
        let leadingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)

        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
}

