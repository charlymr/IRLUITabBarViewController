//
//  IRLUITabBar+Internal.swift
//
//  Created by Denis Martin on 08/01/2017.
//  Copyright © 2017 iRLMobile. All rights reserved.
//

import Foundation
import UIKit

internal protocol IRLUITabBarDataSource {
    func tabBarItemsInCustomTabBar(_ tabBarView: IRLUITabBar) -> [UITabBarItem]
}


internal protocol IRLUITabBarDelegate {
    func didSelectViewController(_ tabBarView: IRLUITabBar, atIndex index: Int)
}

internal extension  IRLUITabBar {
    
    func setup() {
        // get tab bar items from default tab bar
        tabBarItems = datasource.tabBarItemsInCustomTabBar(self)
        
        customTabBarItems = []
        tabBarButtons = []
        
        let containers = createTabBarItemContainers()
        createTabBarItems(containers)
    }
    
    func createTabBarItems(_ containers: [CGRect]) {
        
        var index = 0
        for item in tabBarItems {
            
            let container = containers[index]
            
            let customTabBarItem = IRKabBarItem(frame: container)
            customTabBarItem.setup(item)
            
            self.addSubview(customTabBarItem)
            customTabBarItems.append(customTabBarItem)
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: container.width, height: container.height))
            button.addTarget(self, action: #selector(self.barItemTapped(_:)), for: UIControlEvents.touchUpInside)
            
            customTabBarItem.addSubview(button)
            tabBarButtons.append(button)
            
            index += 1
        }
    }
    
    func createTabBarItemContainers() -> [CGRect] {
        
        var containerArray = [CGRect]()
        
        // create container for each tab bar item
        for index in 0..<tabBarItems.count {
            let tabBarContainer = createTabBarContainer(index)
            containerArray.append(tabBarContainer)
        }
        
        return containerArray
    }
    
    func createTabBarContainer(_ index: Int) -> CGRect {
        
        let tabBarContainerWidth = self.frame.width / CGFloat(tabBarItems.count)
        let tabBarContainerRect = CGRect(x: tabBarContainerWidth * CGFloat(index), y: 0, width: tabBarContainerWidth, height: self.frame.height)
        
        return tabBarContainerRect
    }
    
    @objc func barItemTapped(_ sender : UIButton) {
        let index = tabBarButtons.index(of: sender)!
        
        delegate.didSelectViewController(self, atIndex: index)
    }
    
}

internal extension IRKabBarItem {
    
    func setup(_ item: UITabBarItem) {
        
        guard let image = item.image else {
            fatalError("add images to tabbar items")
        }
        
        // create imageView centered within a container
        iconView = UIImageView(frame: CGRect(x: (frame.width-image.size.width)/2, y: (frame.height-image.size
            .height)/2, width: frame.width, height: frame.height))
        
        iconView.image = image
        iconView.sizeToFit()
        self.addSubview(iconView)

        // Create title view
        titleView = UILabel(frame: CGRect(x: 0, y: frame.height-10, width: frame.width, height: 10))
        titleView.font = UIFont.boldSystemFont(ofSize: 8)
        titleView.adjustsFontSizeToFitWidth = true
        titleView.textAlignment = .center
        titleView.text = item.title
        self.addSubview(titleView)
        
    }
    
}

extension IRLUITabBarController: IRLUITabBarDataSource, IRLUITabBarDelegate {
    
    // MARK: - IRLUITabBarDataSource
    
    internal func tabBarItemsInCustomTabBar(_ tabBarView: IRLUITabBar) -> [UITabBarItem] {
        return tabBar.items!
    }
    
    // MARK: - IRLUITabBarDelegate
    
    internal func didSelectViewController(_ tabBarView: IRLUITabBar, atIndex index: Int) {
        
        let transform =
            CGAffineTransform.identity
                .scaledBy(x: CGFloat(selectedScale), y: CGFloat(selectedScale))
                .translatedBy(x: 0, y: CGFloat(selectedOffset))
        
        guard let viewController = viewControllers?[index] else {
            return
        }
        
        // Pop to root in cas of nav and double tap button
        if let nav = viewController as? UINavigationController,
            self.selectedIndex == index {
            nav.popToRootViewController(animated: true)
        }
        
        let selected = tabBarView.customTabBarItems[index]
        let leftToRight = self.selectedIndex < index
        self.selectedIndex = index
        
        // Animate View Controlelr or not
        if transitonAnimated == true  {
            viewController.view.transform =         CGAffineTransform.identity
                .translatedBy(x: leftToRight ? -40 : 40, y: 0)
            
        }

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            
            for item in self.customTabBar.customTabBarItems {
                item.transform = CGAffineTransform.identity
                item.alpha = 0.8
            }
            selected.transform = transform
            selected.alpha = 1
            
            viewController.view.transform = CGAffineTransform.identity
            
        }) { (_) in
        }
        
        
    }
    
}
