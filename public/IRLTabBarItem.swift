//
//  IRLUITabBarItem.swift
//
//  Created by Denis Martin on 07/01/2017.
//  Copyright © 2017 iRLMobile. All rights reserved.
//

import Foundation
import UIKit

public class IRKabBarItem: UIView {
    
    public var iconView: UIImageView!
    public var titleView: UILabel!
    
    override init (frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init () {
        self.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
