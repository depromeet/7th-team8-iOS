//
//  UIView.swift
//  SweattKit
//
//  Created by 진호놀이터 on 2019/12/19.
//  Copyright © 2019 진호놀이터. All rights reserved.
//

import UIKit


extension  UIView {
    
     func anchor(_ top: NSLayoutYAxisAnchor? = nil, _ leading: NSLayoutXAxisAnchor? = nil, _  bottom: NSLayoutYAxisAnchor? = nil, _ trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
          leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
             bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    open func adjustToArea(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superviewTopAnchor = superview?.topAnchor,
            let superviewBottomAnchor = superview?.bottomAnchor,
            let superviewLeadingAnchor = superview?.leadingAnchor,
            let superviewTrailingAnchor = superview?.trailingAnchor else {
                return
        }
        anchor(superviewTopAnchor, superviewLeadingAnchor, superviewBottomAnchor, superviewTrailingAnchor, padding: padding)
        
    }
}

@available(iOS 9.0, *)
extension UIView {
    
    public func frame<T: UIView>(width: CGFloat? = nil, height: CGFloat? = nil) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(padding: .zero, size: CGSize(width: width ?? 0, height: height ?? 0))
        return self as! T
    }
    
    @discardableResult
    func withBorder<T: UIView>(width: CGFloat, color: UIColor) -> T {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        return self as! T
    }
//    func padding<T: UIView>(_ edgeSet: EdgeInset, _ padding: CGFloat) -> T {
//        translatesAutoresizingMaskIntoConstraints = false
//
//        switch edgeSet {
//        case .all:
//        anchor(topAnchor, leadingAnchor, bottomAnchor, trailingAnchor, padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), size: .zero)
//            break
//        case .top:
//            anchor(topAnchor, padding: UIEdgeInsets(top: 0, left:0  padding, bottom: 0, right: 0), size: .zero)
//            break
//        case .bottom: break
//        case .leading: break
//        case .trailing: break
//
//        default: break
//
//        }
//        return self as! T
//    }
}
