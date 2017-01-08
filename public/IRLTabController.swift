//
//  IRLTabController.swift
//
//  Created by Denis Martin on 07/01/2017.
//  Copyright © 2017 iRLMobile. All rights reserved.
//

import Foundation
import UIKit

public class IRLUITabBarController : UITabBarController {
    
    public var customTabBar = IRLUITabBar()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Background White
        view.backgroundColor = UIColor.white
        
        // Do any additional setup after loading the view.
        self.tabBar.isHidden = true
        
        // Create Custom Tab
        customTabBar = IRLUITabBar(frame: tabBar.frame)
        customTabBar.datasource = self
        customTabBar.delegate = self
        customTabBar.setup()
        
        self.view.addSubview(customTabBar)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        didSelectViewController(customTabBar, atIndex: 0)
    }
    
}
