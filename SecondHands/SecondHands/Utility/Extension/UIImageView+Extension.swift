//
//  UIImageView+Extension.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 13/06/22.
//

import UIKit

extension UIImageView {
        func loadImageWithUrl(_ url: URL) {
            var imageURL: URL?
            let activityIndicator = UIActivityIndicatorView()
            let imageCache = NSCache<AnyObject, AnyObject>()
            // setup activityIndicator...
            activityIndicator.color = .darkGray

            addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

            imageURL = url

            image = nil
            activityIndicator.startAnimating()

            // retrieves image if already available in cache
            if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {

                self.image = imageFromCache
                activityIndicator.stopAnimating()
                return
            }

            // image does not available in cache.. so retrieving it from url...
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

                if error != nil {
                    print(error as Any)
                    DispatchQueue.main.async(execute: {
                        activityIndicator.stopAnimating()
                    })
                    return
                }

                DispatchQueue.main.async(execute: {

                    if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {

                        if imageURL == url {
                            self.image = imageToCache
                        }

                        imageCache.setObject(imageToCache, forKey: url as AnyObject)
                    }
                    activityIndicator.stopAnimating()
                })
            }).resume()
        }
    func loadImage(resource: URL?) {
        guard let resource = resource else { return }
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: resource) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                self.backgroundColor = .white
            }
        }
    }
    
    func loadImage(resource: String?) {
        backgroundColor = .secondarySystemBackground
        guard let resource = resource, let url = URL(string: resource) else {
            backgroundColor = .white
            return
        }
//        loadImage(resource: url)
        loadImageWithUrl(url)
    }
}
