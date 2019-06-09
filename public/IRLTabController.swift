//
//  IRLTabController.swift
//
//  Created by Denis Martin on 07/01/2017.
//  Copyright © 2017 iRLMobile. All rights reserved.
//

import Foundation
import UIKit

public class IRLUITabBarController : UITabBarController {
    
    @IBInspectable public var transitonAnimated: Bool = true
    
    @IBInspectable public var selectedScale: Double = 2.0
    @IBInspectable public var selectedOffset: Double = -12
    @IBInspectable public var itemScale: Float = 1.0
    @IBInspectable public var itemOffsetY: Float = 0.0

    public var customTabBar = IRLUITabBar()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Background White
        view.backgroundColor = UIColor.white
        
        // Do any additional setup after loading the view.
        self.tabBar.isHidden = true
        
        // Create Custom Tab
        customTabBar = IRLUITabBar(frame: tabBar.frame)
        customTabBar.itemScale = itemScale
        customTabBar.itemOffsetY = itemOffsetY
        customTabBar.datasource = self
        customTabBar.delegate = self
        customTabBar.setup()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(statusBarFrameDidChange),
            name: UIApplication.didChangeStatusBarFrameNotification,
            object: nil)
        fixViewSizeDependingOnStatusbar()
        self.view.layoutIfNeeded()

        self.view.addSubview(customTabBar)
    }
    
    private func fixViewSizeDependingOnStatusbar() {
        UIView.animate(withDuration: 0.2) {
            self.customTabBar.frame = self.tabBar.frame
        }
    }
    
    override public func viewWillLayoutSubviews() {
        fixViewSizeDependingOnStatusbar()
        super.viewWillLayoutSubviews()
    }
    
    @objc func statusBarFrameDidChange() {
        fixViewSizeDependingOnStatusbar()
        self.view.layoutIfNeeded()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        didSelectViewController(customTabBar, atIndex: 0)
        customTabBar.frame = tabBar.frame
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customTabBar.frame = tabBar.frame
        setNeedsStatusBarAppearanceUpdate()
    }

}
