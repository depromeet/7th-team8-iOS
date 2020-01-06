//
//  HorizontalStack.swift
//  SweattKit
//
//  Created by 진호놀이터 on 2019/12/11.
//  Copyright © 2019 진호놀이터. All rights reserved.
//

import UIKit

struct HorizontalStack {
    
    var stackView: UIStackView = UIStackView()
    
    init(alignment: NSLayoutConstraint.Axis = .horizontal, spacing: CGFloat? = nil, @ViewArrayBuilder _ content: () -> [UIView]) {
        
        stackView = UIStackView(arrangedSubviews: content())
        stackView.axis = alignment
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = spacing ?? 0
    }
    
    @discardableResult
    func build() -> UIStackView {
        return stackView
    }
    
    public func build(on view: UIView) {
        view.addSubview(stackView)
        stackView.adjustToArea()
    }
    
   
    
}
