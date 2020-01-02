//
//  MainViewCotroller.swift
//  NoNoPlan
//
//  Created by 진호놀이터 on 2019/12/28.
//  Copyright © 2019 진호놀이터. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "메인화면"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .blue
        label.frame = CGRect(x: view.center.x, y: view.center.y, width: 100, height: 100)
        view.addSubview(label)
    }
    
    
}
