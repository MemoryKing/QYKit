//
//  UIButton+YJEX.swift
//  Express
//
//  Created by 祎 on 2019/7/23.
//  Copyright © 2019 祎. All rights reserved.
//

import UIKit

public enum ButtonPosition : NSInteger {
    case left
    case right
    case top
    case bottom
}

extension  UIButton {

    public func imagePosition(_ position : ButtonPosition, spacing : CGFloat) {
        
        let imageSize = imageView!.image!.size
        let titleFont = titleLabel?.font!
        let str = titleLabel!.text! as NSString
        let titleSize = str.size(withAttributes: [NSAttributedString.Key.font: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width),
                                       bottom: 0,
                                       right: 0)
            
            imageInsets = UIEdgeInsets(top: 0,
                                       left: 0,
                                       bottom: -spacing,
                                       right: -titleSize.width)
            
        case .bottom:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width),
                                       bottom: 0,
                                       right: 0)
            
            imageInsets = UIEdgeInsets(top: 0,
                                       left: 0,
                                       bottom: spacing,
                                       right: -titleSize.width)
            
        case .left:
            titleInsets = UIEdgeInsets(top: 0,
                                       left: 0,
                                       bottom: 0,
                                       right: -spacing)
            
            imageInsets = UIEdgeInsets(top: 0,
                                       left: spacing,
                                       bottom: 0,
                                       right: 0)
            
        case .right:
            titleInsets = UIEdgeInsets(top: 0,
                                       left: -(imageSize.width * 2 + spacing),
                                       bottom: 0,
                                       right: 0)
            
            imageInsets = UIEdgeInsets(top: 0,
                                       left: 0,
                                       bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
    
    
    
}
