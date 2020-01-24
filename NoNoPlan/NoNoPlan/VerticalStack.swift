//
//  VerticalStack.swift
//  SweattKit
//
//  Created by 진호놀이터 on 2019/12/11.
//  Copyright © 2019 진호놀이터. All rights reserved.
//

import UIKit

public enum EdgeInset {
    case  all, top, bottom, leading, trailing,horizontal, vertical
    
}

class VerticalStack: UIStackView {
    
    
    
    convenience init(alignment: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat? = nil, @ViewArrayBuilder _ content: () -> UIStackView) {
        self.init(arrangedSubviews: content().arrangedSubviews)
        self.axis = alignment
        self.distribution = .fill
        self.alignment = .fill
        self.spacing = spacing ?? 0.0
        
    }
    
    @discardableResult
    func build() -> UIStackView {
        return self
    }
    
    public func build(on view: UIView) {
        view.addSubview(self)
        self.adjustToArea()
    }
   
    
}

@available(iOS 9.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
@_functionBuilder
struct ViewArrayBuilder {
    
    static func buildBlock(_ views: UIView...) -> UIStackView{
        
      
        return UIStackView(arrangedSubviews: views)
    }
    
    static func buildBlock(_ view: UIView) -> UIStackView {
        
      
        return UIStackView(arrangedSubviews: [view])
    }
}









