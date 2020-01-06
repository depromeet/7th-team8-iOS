//
//  UIStackView.swift
//  SweattKit
//
//  Created by 진호놀이터 on 2019/12/19.
//  Copyright © 2019 진호놀이터. All rights reserved.
//

import UIKit


extension UIStackView {
    
    public func padding(_ edges: EdgeInset = .all, _ length: CGFloat? = nil) -> UIStackView {

        switch edges {
        case .top:
            isLayoutMarginsRelativeArrangement = true
            layoutMargins.top = length ?? 0
            break
        case .bottom:
            isLayoutMarginsRelativeArrangement = true
            layoutMargins.bottom = length ?? 0
            break
        case .leading:
            isLayoutMarginsRelativeArrangement = true
            layoutMargins.left = length ?? 0
            break
        case .trailing:
            isLayoutMarginsRelativeArrangement = true
            layoutMargins.right = length ?? 0
            break
        case .all:
            isLayoutMarginsRelativeArrangement = true
            layoutMargins.top = length ?? 0
            layoutMargins.bottom = length ?? 0
            layoutMargins.left = length ?? 0
            layoutMargins.right = length ?? 0
            break
        default:
            break
        }
        return self
    }   
}
