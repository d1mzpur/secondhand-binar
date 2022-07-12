//
//  LayoutSection.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 20/06/22.
//

import SwiftUI
enum Section: CaseIterable {
    case banner
    case category
    case productList
}

class LayoutSection {
    
    static func createHomeLayout(getHeightSuperView: CGFloat) -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, environment) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                let section = LayoutSection().createLayoutBanner(getHeightSuperView: getHeightSuperView)
                section.orthogonalScrollingBehavior = .paging
                return section
            } else if sectionNumber == 1 {
                let section = LayoutSection().createLayoutChips()
                section.contentInsets = .init(top: 16, leading: 16, bottom: 32, trailing: 16)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20)), elementKind: "categoryId", alignment: .topLeading)]
                return section
            } else {
                return LayoutSection().createLayoutProductList()
            }
        }
    }
    
    static func createSellerProduct() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, environment) -> NSCollectionLayoutSection? in
            if section == 0 {
                let section = LayoutSection().createLayoutChips()
                section.contentInsets = .init(top: 0, leading: 16, bottom: 24, trailing: 16)
                return section
            } else {
                let section = LayoutSection().createLayoutProductList()
                
                return section
            }
            
        }
    }
    
    static func createLayoutCategory() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, environment) -> NSCollectionLayoutSection? in
            let section = LayoutSection().createLayoutChips()
            section.contentInsets =  .init(top: 0, leading: 16, bottom: 8, trailing: 16)
            return section
        }
    }
}

extension LayoutSection {
    private func createLayoutBanner(getHeightSuperView: CGFloat) -> NSCollectionLayoutSection {
        //        let sizeTopBar = getHeightSuperView
        //        let heightItem = 200 + sizeTopBar + 16
        let heightItem: CGFloat = 200
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(heightItem))
        let itemBanner = NSCollectionLayoutItem(layoutSize: layoutSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(heightItem))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemBanner])
        
        let section = NSCollectionLayoutSection(group: group)
        //        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func createLayoutChips() -> NSCollectionLayoutSection {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let itemCategory = NSCollectionLayoutItem(layoutSize: layoutSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(110), heightDimension: .absolute(44))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemCategory])
        group.interItemSpacing = .flexible(10)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        return section
    }
    
    func createLayoutProductList() -> NSCollectionLayoutSection {
        
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.6))
        
        let itemCategory = NSCollectionLayoutItem(layoutSize: layoutSize)
        //        itemCategory.contentInsets.trailing = 16
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemCategory])
        let section = NSCollectionLayoutSection(group: group)
        //        section.contentInsets.leading = 16
        //        section.interGroupSpacing = 16
        return section
    }
    
    func createLayoutSeller() -> NSCollectionLayoutSection {
        let heightItem: CGFloat = 80
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(heightItem))
        let itemBanner = NSCollectionLayoutItem(layoutSize: layoutSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(heightItem))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemBanner])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

struct VCPreview: PreviewProvider {
    
    static var previews: some View {
        VCContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct VCContainerView: UIViewControllerRepresentable {
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<VCPreview.VCContainerView>) -> UIViewController {
            return UINavigationController(rootViewController: SCHomeViewController())
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<VCPreview.VCContainerView>) {
            
        }
        
        typealias UIViewControllerType = UIViewController
    }
}
