//
//  SCTabBar.swift
//  SecondHands
//
//  Created by Tatang Sulaeman on 16/06/22.
//

import UIKit

class SCTabBar: UITabBarController , UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        UITabBar.appearance().barTintColor = .white
        tabBar.tintColor = .purple
        self.tabBar.selectedItem?.badgeColor = UIColor.purple
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
        //tab 1
        let tab1 = SCHomeViewController()
        let nav1 = UINavigationController(rootViewController: tab1)
        let tab1Item = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        tab1.tabBarItem = tab1Item
        
        //tab 2
        let tab2 = SCSellerUploadViewController()
        let nav2 = UINavigationController(rootViewController: tab2)
        let tab2Item = UITabBarItem(title: "Notifikasi", image: UIImage(systemName: "bell"), selectedImage: UIImage(systemName: "bell"))
        tab2.tabBarItem = tab2Item
        
        //tab 3
        let tab3 = SCSellerProductListViewController2()
        let nav3 = UINavigationController(rootViewController: tab3)
        let tab3Item = UITabBarItem(title: "Jual", image: UIImage(systemName: "plus.circle"), selectedImage: UIImage(systemName: "plus.circle"))
        tab3.tabBarItem = tab3Item
        
        //tab 4
        let tab4 = SCSellerProductListViewController()
        let nav4 = UINavigationController(rootViewController: tab4)
        let tab4Item = UITabBarItem(title: "Daftar Jual", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
        tab4.tabBarItem = tab4Item
        
        //tab 5
        let tab5 = SCAccountViewController()
        let nav5 = UINavigationController(rootViewController: tab5)
        let tab5Item = UITabBarItem(title: "Akun", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        tab5.tabBarItem = tab5Item
        
        self.viewControllers = [nav1,nav2,nav3,nav4,nav5]
        
        
    }
    

}
