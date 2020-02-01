//
//  EvaluationView.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2020/01/26.
//  Copyright © 2020 진호놀이터. All rights reserved.
//

import UIKit



class EvaluationView: UIView {
    
    let evaluations: [UIButton] =  [UIButton(),UIButton(),UIButton(),UIButton(),UIButton()]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        evaluations.enumerated().forEach{
            $1.tag = $0
            
        }
        
        
        let stack = UIStackView()
        
        stack.alignment = .leading
        stack.axis = .horizontal
        stack.spacing = 2
        evaluations.forEach{
            stack.addArrangedSubview($0)
        }
       // stack.addArrangedSubview(Space())
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        stack.adjustToArea()
        
       
        evaluations.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalToConstant: 12).isActive = true
            
        }
    }
    
    func setEvaluation(_ value: Int) {
        
        evaluations.forEach{
            if $0.tag <= value {
                $0.setImage(UIImage(named: "star_on"), for: .normal)
            } else {
               
                $0.setImage(UIImage(named: "star_off"), for: .normal)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
