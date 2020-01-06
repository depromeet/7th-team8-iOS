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

struct VerticalStack {
    
    var stackView: UIStackView = UIStackView()
    
    init(alignment: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat? = nil, @ViewArrayBuilder _ content: () -> [UIView]) {
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

@available(iOS 9.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
@_functionBuilder
struct ViewArrayBuilder {
    
    static func buildBlock(_ views: UIView...) -> [UIView] {
        
        let array = views.map{
            return $0
        }
        return array
    }
}









