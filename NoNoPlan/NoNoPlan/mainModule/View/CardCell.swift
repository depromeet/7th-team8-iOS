//
//  CardCell.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2019/12/29.
//  Copyright © 2019 진호놀이터. All rights reserved.
//

import UIKit

extension CardCell: ReusableView, NibLoadableView {}
class CardCell: UICollectionViewCell {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.backgroundColor = .red
    }
    
    
    
}
