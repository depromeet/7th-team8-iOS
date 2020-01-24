//
//  Spacer.swift
//  SweattKit
//
//  Created by 진호놀이터 on 2019/12/19.
//  Copyright © 2019 진호놀이터. All rights reserved.
//

import UIKit



class Space: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setContentHuggingPriority(.defaultLow, for: .horizontal)
        self.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
