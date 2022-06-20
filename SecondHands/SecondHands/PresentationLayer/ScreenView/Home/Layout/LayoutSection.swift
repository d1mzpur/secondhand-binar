//
//  LayoutSection.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 20/06/22.
//

import UIKit
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
        let layoutSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(44))
        let itemCategory = NSCollectionLayoutItem(layoutSize: layoutSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemCategory])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets.leading = 16
        section.contentInsets.bottom = 32
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: "categoryId", alignment: .topLeading)]
        return section
    }
    
    private func createLayoutProductList(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.66))
        
        let itemCategory = NSCollectionLayoutItem(layoutSize: layoutSize)
        itemCategory.contentInsets.trailing = 16
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemCategory])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 16
        section.interGroupSpacing = 16
        return section
        
//        let desiredWidth: CGFloat = 230
//        let itemCount = environment.container.effectiveContentSize.width / desiredWidth
//        let fractionWidth: CGFloat = 1 / (itemCount.rounded())
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractionWidth), heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets.uniform(size: 10)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//        let section = NSCollectionLayoutSection(group: group)
////        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(200))
////        let itemCategory = NSCollectionLayoutItem(layoutSize: layoutSize)
////        itemCategory.contentInsets.trailing = 16
////
////        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
////        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemCategory])
////
////        let section = NSCollectionLayoutSection(group: group)
////        section.contentInsets.leading = 16
////        section.interGroupSpacing = 16
//        return section
    }
}


extension NSDirectionalEdgeInsets {
    static func uniform(size: CGFloat) -> NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets(top: size, leading: size, bottom: size, trailing: size)
    }
    
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
    
    static func small() -> NSDirectionalEdgeInsets {
        return .uniform(size: 5)
    }
    
    static func medium() -> NSDirectionalEdgeInsets {
        return .uniform(size: 15)
    }
    
    static func large() -> NSDirectionalEdgeInsets {
        return .uniform(size: 30)
    }
}
