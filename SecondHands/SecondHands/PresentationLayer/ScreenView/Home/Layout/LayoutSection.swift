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
    
    static func createLayout(getHeightSuperView: CGFloat) -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, environment) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                return LayoutSection().createLayoutBanner(getHeightSuperView: getHeightSuperView)
            } else if sectionNumber == 1 {
                return LayoutSection().createLayoutChips()
            } else {
                return LayoutSection().createLayoutProductList(environment: environment)
            }
        }
    }
}

extension LayoutSection {
    private func createLayoutBanner(getHeightSuperView: CGFloat) -> NSCollectionLayoutSection {
        let sizeTopBar = getHeightSuperView
        let heightItem = 200 + sizeTopBar + 16
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(heightItem))
        let itemBanner = NSCollectionLayoutItem(layoutSize: layoutSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(heightItem))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemBanner])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = -getHeightSuperView
        return section
    }
    
    private func createLayoutChips() -> NSCollectionLayoutSection {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let itemCategory = NSCollectionLayoutItem(layoutSize: layoutSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(110), heightDimension: .absolute(44))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemCategory])
        group.interItemSpacing = .flexible(10)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets.leading = 16
        section.contentInsets.bottom = 32
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: "categoryId", alignment: .topLeading)]
        return section
    }
    
    private func createLayoutProductList(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.6))
        
        let itemCategory = NSCollectionLayoutItem(layoutSize: layoutSize)
        itemCategory.contentInsets.trailing = 16
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(206))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemCategory])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 16
        section.interGroupSpacing = 16
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
