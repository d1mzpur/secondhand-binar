//
//  SCHomeViewController.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 13/06/22.
//

import UIKit

class SCHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .white
        title = "Second Hand"
    }

}
