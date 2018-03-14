//
//  LayoutSpecExtensions.swift
//  Drjoy
//
//  Created by Manh Pham on 8/5/17.
//  Copyright © 2017 Dr.JOY No,054. All rights reserved.
//

import Foundation
import AsyncDisplayKit

extension ASInsetLayoutSpec{
    convenience init(top: CGFloat, child: ASLayoutElement){
        self.init(insets: UIEdgeInsetsMake(top, 0, 0, 0), child: child)
    }
    convenience init(left: CGFloat, child: ASLayoutElement){
        self.init(insets: UIEdgeInsetsMake(0, left, 0, 0), child: child)
    }
    convenience init(bottom: CGFloat, child: ASLayoutElement){
        self.init(insets: UIEdgeInsetsMake(0, 0, 0, 0), child: child)
    }
    convenience init(right: CGFloat, child: ASLayoutElement){
        self.init(insets: UIEdgeInsetsMake(0, 0, 0, right), child: child)
    }
    convenience init(all: CGFloat, child: ASLayoutElement){
        self.init(insets: UIEdgeInsets(top: all, left: all, bottom: all, right: all), child: child)
    }
    
}

extension ASCenterLayoutSpec {
    convenience init(centerXY child: ASLayoutElement){
        self.init(centeringOptions: .XY, sizingOptions: .init(rawValue: 0), child: child)
    }
}
