//
//  HorizontalStack.swift
//  SweattKit
//
//  Created by 진호놀이터 on 2019/12/11.
//  Copyright © 2019 진호놀이터. All rights reserved.
//

import UIKit

class HorizontalStack: UIStackView {
    
    
    
    convenience init(axis: NSLayoutConstraint.Axis = .horizontal, alignment: UIStackView.Alignment = .fill, spacing: CGFloat? = nil, @ViewArrayBuilder _ content: () -> UIStackView) {
        self.init(arrangedSubviews: content().arrangedSubviews)
        self.axis = axis
        self.distribution = .fill
        self.alignment = alignment
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
