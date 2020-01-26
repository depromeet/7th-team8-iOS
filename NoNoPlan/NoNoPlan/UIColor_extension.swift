//
//  UIColor_extension.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2020/01/24.
//  Copyright © 2020 진호놀이터. All rights reserved.
//

import UIKit


extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
