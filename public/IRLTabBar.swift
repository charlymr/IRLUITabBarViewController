//
//  IRLUITabBar.swift
//
//  Created by Denis Martin on 07/01/2017.
//  Copyright © 2017 iRLMobile. All rights reserved.
//

import Foundation
import UIKit

public class IRLUITabBar: UIView {
    
    public var tabBarItems:         [UITabBarItem]!
    public var customTabBarItems:   [IRKabBarItem]!
    public var tabBarButtons:       [UIButton]!
    public var itemScale: Float = 1.0
    public var itemOffsetY: Float = 1.0

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal var datasource: IRLUITabBarDataSource!
    internal var delegate: IRLUITabBarDelegate!
    override internal init(frame: CGRect) {
        super.init(frame: frame)
        
        contentScaleFactor = UIScreen.main.scale

        if #available(iOSApplicationExtension 13.0, *) {
            self.backgroundColor = UIColor.systemBackground
        } else {
            // Fallback on earlier versions
            self.backgroundColor = UIColor.white
        }
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        
    }
    
    
    
}


