//
//  Text.swift
//  SweattKit
//
//  Created by 진호놀이터 on 2019/12/19.
//  Copyright © 2019 진호놀이터. All rights reserved.
//

import UIKit


class Text: UILabel  {
    
  // public init<S>(_ content: S) where S : StringProtocol
    init<S>(_ content: S) where S: StringProtocol {
        super.init(frame: .zero)
        self.text = content as? String
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
